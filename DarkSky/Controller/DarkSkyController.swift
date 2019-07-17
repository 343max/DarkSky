import Combine
import Foundation
import SwiftUI

protocol DarkSkyLoader {
    func forecast(for location: Location.Coordinates) -> AnyPublisher<Data, URLError>
}

final class DarkSkyNetworkLoader: DarkSkyLoader {
    let apiKey: String
    let session: URLSession

    init(apiKey: String, session: URLSession = URLSession.shared) {
        self.apiKey = apiKey
        self.session = session
    }

    func forecast(for location: Location.Coordinates) -> AnyPublisher<Data, URLError> {
        let url = URL(string: "https://api.darksky.net/forecast/\(apiKey)/\(location.lat),\(location.long)")!
        return session.dataTaskPublisher(for: url)
            .map { $0.data }
            .eraseToAnyPublisher()
    }
}

#if DEBUG

final class DarkSkyDiskLoader: DarkSkyLoader {
    enum SourceFile: String {
        case forecast = "forecast"
        case usageLimitError = "usageLimitExceeded"
    }
    
    let json: SourceFile
    let bundle: Bundle
    
    var jsonURL: URL { Bundle.main.url(forResource: json.rawValue, withExtension: "json")! }
    
    init(json: SourceFile = .forecast, bundle: Bundle = Bundle.main) {
        self.json = json
        self.bundle = bundle
    }
    
    var forecast: Forecast {
        let data = try! Data(contentsOf: jsonURL)
        return try! JSONDecoder().decode(Forecast.self, from: data)
    }
    
    func forecast(for location: Location.Coordinates) -> AnyPublisher<Data, URLError> {
        let data = try! Data(contentsOf: jsonURL)
        
        return Just(data)
            .setFailureType(to: URLError.self)
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
    var willChange = PassthroughSubject<Void, Never>()
    
    let loader: DarkSkyLoader
    let cacher: DarkSkyCaching?
    
    private func sendDidChange() {
        DispatchQueue.main.async {
            self.willChange.send()
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
            .decode(type: Forecast.self, decoder: JSONDecoder())
        
        cancellables += [loader
            .catch { _ in Empty() }
            .sink { [unowned self] (forecast) in
                self.forecasts[location.id] = forecast
                try? self.cacher?.save(location: location.id, forecast: forecast)
            }]
        
        cancellables += [loader.catch { (error) -> Empty<Forecast, Never> in
            debugPrint("error: \(error)")
            return Empty<Forecast, Never>()
        }.sink(receiveValue: { (_) in
            //
        })]
        
        return loader.share().eraseToAnyPublisher()
    }
}

extension Publisher {
    public func ignoreErrors() -> AnyPublisher<Self.Output, Never> {
        return self.catch { (_) in
            Empty<Self.Output, Never>()
        }.eraseToAnyPublisher()
    }
}
