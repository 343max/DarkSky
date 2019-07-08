// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let dailyDatum = try? newJSONDecoder().decode(DailyDatum.self, from: jsonData)

import Foundation

// MARK: - DailyDatum
struct DailyDatum: Codable {
    let time: Date
    let summary: String
    let icon: String
    let sunriseTime: Date
    let sunsetTime: Date
    let moonPhase: Double
    let precipIntensity: Double
    let precipIntensityMax: Double
    let precipIntensityMaxTime: Date
    let precipProbability: Double
    let precipType: PrecipType?
    let temperatureHigh: Double
    let temperatureHighTime: Date
    let temperatureLow: Double
    let temperatureLowTime: Date
    let apparentTemperatureHigh: Double
    let apparentTemperatureHighTime: Date
    let apparentTemperatureLow: Double
    let apparentTemperatureLowTime: Date
    let dewPoint: Double
    let humidity: Double
    let pressure: Double
    let windSpeed: Double
    let windGust: Double
    let windGustTime: Date
    let windBearing: Int
    let cloudCover: Double
    let uvIndex: Int
    let uvIndexTime: Date
    let visibility: Double
    let ozone: Double
    let temperatureMin: Double
    let temperatureMinTime: Date
    let temperatureMax: Double
    let temperatureMaxTime: Date
    let apparentTemperatureMin: Double
    let apparentTemperatureMinTime: Date
    let apparentTemperatureMax: Double
    let apparentTemperatureMaxTime: Date

    enum CodingKeys: String, CodingKey {
        case time
        case summary
        case icon
        case sunriseTime
        case sunsetTime
        case moonPhase
        case precipIntensity
        case precipIntensityMax
        case precipIntensityMaxTime
        case precipProbability
        case precipType
        case temperatureHigh
        case temperatureHighTime
        case temperatureLow
        case temperatureLowTime
        case apparentTemperatureHigh
        case apparentTemperatureHighTime
        case apparentTemperatureLow
        case apparentTemperatureLowTime
        case dewPoint
        case humidity
        case pressure
        case windSpeed
        case windGust
        case windGustTime
        case windBearing
        case cloudCover
        case uvIndex
        case uvIndexTime
        case visibility
        case ozone
        case temperatureMin
        case temperatureMinTime
        case temperatureMax
        case temperatureMaxTime
        case apparentTemperatureMin
        case apparentTemperatureMinTime
        case apparentTemperatureMax
        case apparentTemperatureMaxTime
    }
}
