//

import SwiftUI

struct LocationListView : View {
    let locations: [Location]

    var body: some View {
        List {
            ForEach(locations) { LocationCell(location: $0) }
        }
    }
}

#if DEBUG
struct LocationListView_Previews : PreviewProvider {
    static var previews: some View {
        LocationListView(locations: Location.DVLocations)
    }
}
#endif
