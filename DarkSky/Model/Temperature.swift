import Foundation

struct Temperature: Codable {
    private let fahrenheit: Double
    
    enum Unit {
        case celsius
        case fahrenheit

        var stringValue: String {
            switch self {
            case .fahrenheit:
                return "°F"
            case .celsius:
                return "°C"
            }
        }

        mutating func toggle() {
            self = self == .celsius ? .fahrenheit : .celsius
        }
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

    func stringValue(_ unit: Unit) -> String {
        return "\(Int(round(floatValue(unit))))\(unit.stringValue)"
    }
}

extension Double {
    var temperature: Temperature {
        get {
            return Temperature(fahrenheit: self)
        }
    }
}
