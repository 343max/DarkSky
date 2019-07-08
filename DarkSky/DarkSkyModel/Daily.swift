// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let daily = try? newJSONDecoder().decode(Daily.self, from: jsonData)

import Foundation

// MARK: - Daily
struct Daily: Codable {
    let summary: String
    let icon: String
    let data: [DailyDatum]

    enum CodingKeys: String, CodingKey {
        case summary
        case icon
        case data
    }
}
