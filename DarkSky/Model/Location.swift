//

import Foundation
import SwiftUI

struct Location {
    let name: String
    let address: String
    let latLong: (lat: Double, long: Double)
}

extension Location: Identifiable {
    var id: String { "\(latLong.lat)/\(latLong.long)" }
}

extension Location {
    static let DVLocations: [Location] = [
        Location(name: "Manhattan Beach",
                 address: "1240 Rosecrans Ave Suite 500\nManhattan Beach, CA 90266",
                 latLong: (33.901134, -118.392255)),
        Location(name: "Berlin",
                 address: "Dircksenstraße 41\n10178 Berlin, Germany",
                 latLong: (52.524055, 13.406623)),
        Location(name: "Sydney",
                 address: "1-80 George St, The Rocks NSW 2000\nSydney, Australia",
                 latLong: (-33.856894, 151.208803)),
        Location(name: "New York",
                 address: "10 Hudson Yards, 46th Floor\nNew York, NY 10001",
                 latLong: (40.753114, -74.000847)),
        Location(name: "London",
                 address: "30 Broadwick Street\nLondon, W1F 8JB",
                 latLong: (51.509836, -0.137301)),
        Location(name: "Shanghai",
                 address: "41/F, Phase 2, Shanghai IFC,\n8 Century Avenue, Shanghai 200120",
                 latLong: (31.237590, 121.501823)),
        Location(name: "Tokyo",
                 address: "Buena Vista Ebisu 4-5-3\nEbisu, Shibuya-ku Tokyo, 150-0013 Japan",
                 latLong: (35.645512, 139.712611))
    ]
}
