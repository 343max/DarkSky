//

import SwiftUI

struct LocationCell : View {
    let location: Location

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.headline)
                Text(location.address)
                    .lineLimit(nil)
            }
            Spacer()
        }.padding(.all)
    }
}

#if DEBUG
struct LocationCell_Previews : PreviewProvider {
    static var previews: some View {
        LocationCell(location: Location.DVLocations[1])
            .previewLayout(.fixed(width: 400, height: 200))
    }
}
#endif
