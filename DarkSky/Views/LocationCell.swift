//

import Combine
import SwiftUI

struct LocationCell : View {
    let location: Location
    @ObjectBinding var controller: DarkSkyController
    @State var forecast: Forecast? = nil
    
    struct ForecastView: View {
        let forecast: Forecast
        
        var body: some View {
            Text("\(forecast.currently.temperature) °F")
        }
    }

    var body: some View {
        NavigationLink(destination: LocationDetailsView(location: location, controller: controller)) {
            HStack {
                VStack(alignment: .leading) {
                    Text(location.name)
                        .font(.headline)
                    Text(location.address)
                        .font(.footnote)
                        .lineLimit(nil)
                }
                Spacer()
                if (self.forecast != nil) {
                    ForecastView(forecast: self.forecast!)
                }
            }
        }
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
