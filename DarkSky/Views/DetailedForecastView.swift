//

import SwiftUI

struct DetailedForecastView : View {
    let forecast: Forecast
    @Environment(\.weatherUnits) private var weatherUnits: WeatherUnits
    
    struct HourlyView : View {
        let hourly: HourlyDatum
        @Environment(\.weatherUnits) private var weatherUnits: WeatherUnits
        
        static let dateFormatter: DateFormatter = {
            let df = DateFormatter()
            df.dateStyle = .none
            df.timeStyle = .short
            return df
        }()

        var body: some View {
            VStack {
                Text(hourly.icon.emoji)
                Text(hourly.temperature.temperature.stringValue(weatherUnits.temperature))
                Text(HourlyView.dateFormatter.string(from: hourly.time))
                    .font(.caption)
                    .color(.gray)
            }.frame(width: 80)
        }
    }
    
    struct DailyView : View {
        let daily: DailyDatum
        @Environment(\.weatherUnits) private var weatherUnits: WeatherUnits
        
        static let dateFormatter: DateFormatter = {
            let df = DateFormatter()
            df.dateFormat = "EEEE"
            return df
        }()
        
        var body: some View {
            HStack {
                Text(DailyView.dateFormatter.string(from: daily.time))
                Spacer()
                Text(daily.icon.emoji)
                Spacer()
                    .frame(width: 40)
                Text(daily.temperatureHigh.temperature.stringValue(weatherUnits.temperature))
                    .frame(width: 55)
                Text(daily.temperatureLow.temperature.stringValue(weatherUnits.temperature))
                    .color(.gray)
                    .frame(width: 55)
            }.padding(.bottom, 2)
        }

    }
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                Text(forecast.currently.temperature.temperature.stringValue(weatherUnits.temperature))
                    .font(.system(size: 62))
                    .fontWeight(.semibold)
                Text(forecast.currently.icon.emoji).padding(.bottom)
                Text(forecast.currently.summary)
                
                VStack {
                    HStack {
                        Text("\(forecast.hourly.icon.emoji) \(forecast.hourly.summary)")
                        Spacer()
                    }
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(forecast.hourly.data) { (hourly) in
                                HourlyView(hourly: hourly)
                            }
                        }
                    }
                }.padding(.all)
                
                VStack {
                    ForEach(forecast.daily.data) { (daily) in
                        DailyView(daily: daily)
                    }
                }.padding([.leading, .trailing])
            }
        }
    }
}

#if DEBUG
struct DetailedForecastView_Previews : PreviewProvider {
    static var previews: some View {
        DetailedForecastView(forecast: DarkSkyDiskLoader().forecast)
    }
}
#endif
