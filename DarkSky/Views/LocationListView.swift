//

import SwiftUI

struct LocationListView : View {
    let locations: [Location]
    @ObjectBinding var controller: DarkSkyController

    var body: some View {
        List {
            ForEach(locations) { LocationCell(location: $0, controller: self.controller) }
        }.navigationBarTitle("Weather")
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
