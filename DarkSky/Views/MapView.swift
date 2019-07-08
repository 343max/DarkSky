//

import MapKit
import SwiftUI

struct MapView : UIViewRepresentable {
    let center: Location.Coordinates
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.region = MKCoordinateRegion.init(center: CLLocationCoordinate2D(latitude: center.lat, longitude: center.long),
                                                 latitudinalMeters: 500,
                                                 longitudinalMeters: 500)
        mapView.mapType = .satellite
        mapView.isUserInteractionEnabled = false
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        //
    }
}

#if DEBUG
struct MapView_Previews : PreviewProvider {
    static var previews: some View {
        MapView(center: Location.Coordinates(52.524055, 13.406623))
            .previewLayout(.fixed(width: 400, height: 80))
    }
}
#endif
