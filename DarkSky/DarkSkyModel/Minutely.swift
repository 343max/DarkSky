// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let minutely = try? newJSONDecoder().decode(Minutely.self, from: jsonData)

import Foundation

// MARK: - Minutely
struct Minutely: Codable {
    let summary: String
    let icon: String
    let data: [MinutelyDatum]

    enum CodingKeys: String, CodingKey {
        case summary
        case icon
        case data
    }
}
