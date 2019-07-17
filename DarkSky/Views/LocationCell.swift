//

import Combine
import SwiftUI

struct LocationCell : View {
    let location: Location
    @ObjectBinding var controller: DarkSkyController
    @State var forecast: Forecast? = nil
    
    struct ForecastView: View {
        let forecast: Forecast
        @Environment(\.weatherUnits) private var weatherUnits: WeatherUnits

        var body: some View {
            Text([forecast.currently.icon.emoji,
                  forecast.currently.temperature.temperature.stringValue(weatherUnits.temperature)].joined(separator: " "))
                .font(.system(size: 24, design: .default))
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .shadow(color: Color.black.opacity(0.6), radius: 4, x: 0, y: 2)
        }
    }

    var body: some View {
        NavigationLink(destination: LocationDetailsView(location: location, controller: controller)) {
            HStack {
                Text(location.name)
                    .font(.headline)
                    .foregroundColor(.white)
                    .shadow(color: Color.black.opacity(0.6), radius: 4, x: 0, y: 2)
                Spacer()
                if (controller.forecasts[location.latLong.id] != nil) {
                    ForecastView(forecast: controller.forecasts[location.latLong.id]!)
                }
            }
        }
        .background(MapView(center: location.latLong)
                .padding([.leading, .trailing], -20)
                .padding([.top, .bottom], -6))
        .frame(height: 60, alignment: .center)
        .onReceive(controller.forecast(for: location.latLong).receive(on: RunLoop.main).ignoreErrors()) {
            self.forecast = $0
        }
    }
}

#if DEBUG
struct LocationCell_Previews : PreviewProvider {
    static var previews: some View {
        LocationCell(location: Location.DVLocations[1], controller: DarkSkyController.debug())
            .previewLayout(.fixed(width: 400, height: 200))
    }
}
#endif
