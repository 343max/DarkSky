import Foundation

protocol DarkSkyCaching {
    func save(location: String, forecast: Forecast) throws
    func loadForecasts() -> [String: Forecast]
}

final class DarkSkyDiscCaching: DarkSkyCaching {
    private let fileManager = FileManager.default
    private var cacheURL: URL {
        fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }
    
    private let prefix = "forecast_"
    private let suffix = ".json"
    
    func save(location: String, forecast: Forecast) throws {
        let url = cacheURL.appendingPathComponent([prefix, location, suffix].joined())
        let data = try JSONEncoder().encode(forecast)
        try data.write(to: url)
    }
    
    func loadForecasts() -> [String : Forecast] {
        let dict = try? fileManager.contentsOfDirectory(at: cacheURL, includingPropertiesForKeys: nil, options: FileManager.DirectoryEnumerationOptions()).filter { (url) -> Bool in
            let name = url.lastPathComponent
            return name.hasPrefix(prefix) && name.hasSuffix(suffix)
        }
        .map { (url) -> (URL, Location.Coordinates) in
            let coordinatesString = String(url.lastPathComponent.dropFirst(prefix.count).dropLast(suffix.count))
            return (url, Location.Coordinates(string: coordinatesString))
        }
        .map { (url, coordinates) -> (Location.Coordinates, Forecast)? in
            do {
                let data = try Data(contentsOf: url)
                let forecast = try JSONDecoder().decode(Forecast.self, from: data)
                return (coordinates, forecast)
            } catch {
                return nil
            }
        }
        .compactMap { $0 }
            .filter {
                $0.1.currently.time > Date(timeIntervalSinceNow: -15 * 60)
        }
        .reduce(Dictionary<String, Forecast>(), { (dict, tuple) -> [String: Forecast] in
            var dict = dict
            dict[tuple.0.id] = tuple.1
            return dict
        })
        
        return dict ?? [:]
    }
}

extension Location.Coordinates {
    init(string: String) {
        let degrees = string.split(separator: "_").map { Double(String($0))! }
        self.init(degrees[0], degrees[1])
    }
}
