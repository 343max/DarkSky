// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let hourlyDatum = try? newJSONDecoder().decode(HourlyDatum.self, from: jsonData)

import Foundation

// MARK: - HourlyDatum
struct HourlyDatum: Codable {
    let time: Int
    let summary: String
    let icon: Icon
    let precipIntensity: Double
    let precipProbability: Double
    let precipType: PrecipType?
    let temperature: Double
    let apparentTemperature: Double
    let dewPoint: Double
    let humidity: Double
    let pressure: Double
    let windSpeed: Double
    let windGust: Double
    let windBearing: Int
    let cloudCover: Double
    let uvIndex: Int
    let visibility: Double
    let ozone: Double

    enum CodingKeys: String, CodingKey {
        case time
        case summary
        case icon
        case precipIntensity
        case precipProbability
        case precipType
        case temperature
        case apparentTemperature
        case dewPoint
        case humidity
        case pressure
        case windSpeed
        case windGust
        case windBearing
        case cloudCover
        case uvIndex
        case visibility
        case ozone
    }
}
