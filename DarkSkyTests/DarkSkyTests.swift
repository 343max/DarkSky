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
        _ = try! json(Forecast.self, filename: "forecast")
    }
    
    func testError() {
        let error = try! json(JSONError.self, filename: "usageLimitExceeded")
        XCTAssertEqual(error.code, 403)
        XCTAssertEqual(error.error, "daily usage limit exceeded")
    }
}
