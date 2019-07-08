import Foundation

struct Temperature: Codable {
    private let fahrenheit: Double
    
    enum Scale {
        case celsius
        case fahrenheit
    }
    
    init(fahrenheit: Double) {
        self.fahrenheit = fahrenheit
    }

    func floatValue(_ scale: Scale) -> Double {
        switch scale {
        case .fahrenheit:
            return fahrenheit
        case .celsius:
            return (fahrenheit - 32) * 5/9
        }
    }

    func sign(_ scale: Scale) -> String {
        switch scale {
        case .fahrenheit:
            return "°F"
        case .celsius:
            return "°C"
        }
    }

    func stringValue(_ scale: Scale) -> String {
        return "\(Int(round(floatValue(scale))))\(sign(scale))"
    }
}

extension Double {
    var temperature: Temperature {
        get {
            return Temperature(fahrenheit: self)
        }
    }
}
