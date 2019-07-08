// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let minutelyDatum = try? newJSONDecoder().decode(MinutelyDatum.self, from: jsonData)

import Foundation

// MARK: - MinutelyDatum
struct MinutelyDatum: Codable {
    let time: Date
    let precipIntensity: Double
    let precipProbability: Double
    let precipIntensityError: Double?
    let precipType: PrecipType?

    enum CodingKeys: String, CodingKey {
        case time
        case precipIntensity
        case precipProbability
        case precipIntensityError
        case precipType
    }
}
