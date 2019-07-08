//

import Foundation
import SwiftUI

struct Location {
    struct Coordinates {
        let lat: Double
        let long: Double
        
        init(_ lat: Double, _ long: Double) {
            self.lat = lat
            self.long = long
        }
    }

    let name: String
    let address: String
    let latLong: Coordinates
}

extension Location.Coordinates: Identifiable {
    var id: String { "\(lat)/\(long)" }
}

extension Location: Identifiable {
    var id: String { latLong.id }
}

extension Location {
    static let DVLocations: [Location] = [
        Location(name: "Manhattan Beach",
                 address: "1240 Rosecrans Ave Suite 500\nManhattan Beach, CA 90266",
                 latLong: Location.Coordinates(33.901134, -118.392255)),
        Location(name: "Berlin",
                 address: "Dircksenstraße 41\n10178 Berlin, Germany",
                 latLong: Location.Coordinates(52.524055, 13.406623)),
        Location(name: "Sydney",
                 address: "1-80 George St, The Rocks NSW 2000\nSydney, Australia",
                 latLong: Location.Coordinates(-33.856894, 151.208803)),
        Location(name: "New York",
                 address: "10 Hudson Yards, 46th Floor\nNew York, NY 10001",
                 latLong: Location.Coordinates(40.753114, -74.000847)),
        Location(name: "London",
                 address: "30 Broadwick Street\nLondon, W1F 8JB",
                 latLong: Location.Coordinates(51.509836, -0.137301)),
        Location(name: "Shanghai",
                 address: "41/F, Phase 2, Shanghai IFC,\n8 Century Avenue, Shanghai 200120",
                 latLong: Location.Coordinates(31.237590, 121.501823)),
        Location(name: "Tokyo",
                 address: "Buena Vista Ebisu 4-5-3\nEbisu, Shibuya-ku Tokyo, 150-0013 Japan",
                 latLong: Location.Coordinates(35.645512, 139.712611))
    ]
}
