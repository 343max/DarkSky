// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let hourly = try? newJSONDecoder().decode(Hourly.self, from: jsonData)

import Foundation

// MARK: - Hourly
struct Hourly: Codable {
    let summary: String
    let icon: Icon
    let data: [HourlyDatum]

    enum CodingKeys: String, CodingKey {
        case summary
        case icon
        case data
    }
}
