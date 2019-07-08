import Foundation

struct Temperature: Codable {
    private let fahrenheit: Double
    
    enum Unit {
        case celsius
        case fahrenheit
    }
    
    init(fahrenheit: Double) {
        self.fahrenheit = fahrenheit
    }

    func floatValue(_ unit: Unit) -> Double {
        switch unit {
        case .fahrenheit:
            return fahrenheit
        case .celsius:
            return (fahrenheit - 32) * 5/9
        }
    }

    func sign(_ unit: Unit) -> String {
        switch unit {
        case .fahrenheit:
            return "°F"
        case .celsius:
            return "°C"
        }
    }

    func stringValue(_ unit: Unit) -> String {
        return "\(Int(round(floatValue(unit))))\(sign(unit))"
    }
}

extension Double {
    var temperature: Temperature {
        get {
            return Temperature(fahrenheit: self)
        }
    }
}
