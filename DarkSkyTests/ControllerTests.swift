import Combine
import XCTest
@testable import DarkSky

class ControllerTests: XCTestCase {
    let berlin = Location.Coordinates(52.524055, 13.406623)
    let bundle = Bundle(for: ControllerTests.self)

    func testLoadForecast() {
        let controller = DarkSkyController(loader: DarkSkyDiskLoader(json: .forecast, bundle: bundle))
        var forecast: Forecast? = nil
        _ = controller.forecast(for: berlin)
            .assertNoFailure()
            .sink { forecast = $0 }
        XCTAssertNotNil(forecast)
    }
    
    func testLoadFail() {
        let controller = DarkSkyController(loader: DarkSkyDiskLoader(json: .usageLimitError, bundle: bundle))
        var forecast: Forecast? = nil
        var error: Error? = nil
        _ = controller.forecast(for: berlin)
            .catch({ (e) -> AnyPublisher<Forecast, Error> in
                error = e
                return Publishers.Empty<Forecast, Error>().eraseToAnyPublisher()
            })
            .sink { forecast = $0 }
        XCTAssertNil(forecast)
        XCTAssertNotNil(error)
    }
}
