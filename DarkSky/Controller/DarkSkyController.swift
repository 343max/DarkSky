import Combine
import Foundation
import SwiftUI

protocol DarkSkyLoader {
    func forecast(for location: Location.Coordinates) -> AnyPublisher<Forecast, Error>
}

final class DarkSkyNetworkLoader: DarkSkyLoader {
    let apiKey: String
    let session: URLSession

    init(apiKey: String, session: URLSession = URLSession.shared) {
        self.apiKey = apiKey
        self.session = session
    }

    func forecast(for location: Location.Coordinates) -> AnyPublisher<Forecast, Error> {
        let url = URL(string: "https://api.darksky.net/forecast/\(apiKey)/\(location.lat),\(location.long)")!
        return session.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Forecast.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

#if DEBUG

final class DarkSkyDiskLoader: DarkSkyLoader {
    static var forecast: Forecast {
        let url = Bundle.main.url(forResource: "forecast", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return try! JSONDecoder().decode(Forecast.self, from: data)
    }
    
    func forecast(for location: Location.Coordinates) -> AnyPublisher<Forecast, Error> {
        return Just(type(of: self).forecast)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

extension DarkSkyController {
    static func debug() -> DarkSkyController {
        return DarkSkyController(loader: DarkSkyDiskLoader())
    }
}

#endif

final class DarkSkyController: BindableObject {
    typealias PublisherType = PassthroughSubject<Void, Never>
    var didChange = PassthroughSubject<Void, Never>()
    
    let loader: DarkSkyLoader
    let cacher: DarkSkyCaching?
    
    private func sendDidChange() {
        DispatchQueue.main.async {
            self.didChange.send()
        }
    }
    
    private(set) var forecasts: [String: Forecast] = [:] { didSet { sendDidChange() } }
    
    var cancellables: [Cancellable] = []
    
    init(loader: DarkSkyLoader, cacher: DarkSkyCaching? = nil) {
        self.loader = loader
        self.cacher = cacher
        forecasts = cacher?.loadForecasts() ?? [:]
    }
    
    func forecast(for location: Location.Coordinates, forceReload: Bool = false) -> AnyPublisher<Forecast, Error> {
        if let forecast = forecasts[location.id], forceReload == false {
            return Just(forecast)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        let loader = self.loader.forecast(for: location)
        
        cancellables += [loader
            .sink { [unowned self] (forecast) in
                self.forecasts[location.id] = forecast
                try? self.cacher?.save(location: location.id, forecast: forecast)
            }]
        
        cancellables += [loader.catch { (error) -> AnyPublisher<Forecast, Error> in
            debugPrint("error: \(error)")
            return Publishers.Empty<Forecast, Error>().eraseToAnyPublisher()
        }.sink(receiveValue: { (_) in
            //
        })]
        
        return loader.share().eraseToAnyPublisher()
    }
}

extension Publisher {
    public func ignoreErrors() -> AnyPublisher<Self.Output, Never> {
        return self.catch { (_) in
            return Publishers.Empty<Self.Output, Never>()
        }.eraseToAnyPublisher()
    }
}
