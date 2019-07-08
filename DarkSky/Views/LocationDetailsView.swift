import Combine
import SwiftUI

struct LocationDetailsView : View {
    let location: Location
    
    @State var forecast: Forecast? = nil
    @State var error: Error? = nil
    
    var cancellable: Cancellable? = nil
    
    struct ForecastView: View {
        let forecast: Forecast
        
        var body: some View {
            Text(forecast.currently.temperature.temperature.stringValue(.celsius)).font(.headline)
        }
    }
    
    @ObjectBinding var controller: DarkSkyController
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text(location.address).lineLimit(nil)
                    Spacer()
                }.padding(.all)
                if (forecast != nil) {
                    ForecastView(forecast: forecast!)
                }
            }
        }
        .navigationBarTitle(location.name)
        .onAppear {
            _ = self.controller.forecast(for: self.location.latLong)
                .ignoreErrors()
                .receive(on: RunLoop.main)
                .sink {
                    self.forecast = $0
                }
        }
//        .onReceive(controller.forecast(for: location.latLong).ignoreErrors().receive(on: RunLoop.main)) {
//            self.forecast = $0
//        }
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
