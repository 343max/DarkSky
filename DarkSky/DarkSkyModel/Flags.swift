// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let flags = try? newJSONDecoder().decode(Flags.self, from: jsonData)

import Foundation

// MARK: - Flags
struct Flags: Codable {
    let sources: [String]
    let nearestStation: Double?
    let units: String

    enum CodingKeys: String, CodingKey {
        case sources
        case nearestStation
        case units
    }
}
