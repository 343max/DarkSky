// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let forecast = try? newJSONDecoder().decode(Forecast.self, from: jsonData)

import Foundation

// MARK: - Forecast
struct Forecast: Codable {
    let latitude: Double
    let longitude: Double
    let timezone: String
    let currently: Currently
    let minutely: Minutely
    let hourly: Hourly
    let daily: Daily
    let flags: Flags
    let offset: Int

    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
        case timezone
        case currently
        case minutely
        case hourly
        case daily
        case flags
        case offset
    }
}
