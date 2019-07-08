//

import SwiftUI

struct WeatherUnits: EnvironmentKey {
    static var defaultValue = WeatherUnits(temperature: .celsius)

    typealias Value = WeatherUnits

    var temperature: Temperature.Unit


}

extension EnvironmentValues {
    var weatherUnits: WeatherUnits {
        get { self[WeatherUnits.self] }
        set { self[WeatherUnits.self] = newValue }
    }
}
