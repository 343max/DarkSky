//

import SwiftUI

struct LocationListView : View {
    let locations: [Location]
    @ObjectBinding var controller: DarkSkyController

    @State private var weatherUnits: WeatherUnits = WeatherUnits(temperature: .celsius)

    var body: some View {
        List {
            ForEach(locations) { LocationCell(location: $0, controller: self.controller) }
        }
        .navigationBarTitle("Weather")
        .navigationBarItems(trailing: Button(weatherUnits.temperature.stringValue, action: {
            self.weatherUnits.temperature.toggle()
        }))
        .environment(\.weatherUnits, weatherUnits)
    }
}

#if DEBUG
struct LocationListView_Previews : PreviewProvider {
    static var previews: some View {
        NavigationView {
            LocationListView(locations: Location.DVLocations, controller: DarkSkyController.debug())
        }
    }
}
#endif
