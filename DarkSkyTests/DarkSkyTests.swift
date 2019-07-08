//

import XCTest
@testable import DarkSky

class DarkSkyTests: XCTestCase {
    func json<T: Decodable>(_ codeableType: T.Type, filename: String) throws -> T {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: filename, withExtension: "json")!
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func testForecast() {
        let forecast = try! json(Forecast.self, filename: "forecast")
    }
}
