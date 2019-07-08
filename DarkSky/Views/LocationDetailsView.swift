import Combine
import SwiftUI

struct LocationDetailsView : View {
    let location: Location
    
    @State var forecast: Forecast? = nil
    @State var error: Error? = nil
    
    var cancellable: Cancellable? = nil
    
    @ObjectBinding var controller: DarkSkyController
    
    var body: some View {
        ScrollView {
            VStack {
                if (forecast != nil) {
                    DetailedForecastView(forecast: forecast!)
                } else {
                    SpinnerView(style: .large).padding(.all)
                }
            }
        }
        .navigationBarTitle(location.name)
        .onReceive(controller.forecast(for: location.latLong).ignoreErrors().receive(on: RunLoop.main)) {
            self.forecast = $0
        }
    }
}

#if DEBUG
struct LocationDetailsView_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView {
            LocationDetailsView(location: Location.DVLocations[1], controller: DarkSkyController.debug())
        }
    }
}
#endif
