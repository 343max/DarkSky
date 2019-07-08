import Foundation

struct Temperature {
    private let fahrenheit: Float
    
    enum Scale {
        case celsius
        case fahrenheit
    }
    
    init(_ fahrenheit: Float) {
        self.fahrenheit = fahrenheit
    }
    
    
}
