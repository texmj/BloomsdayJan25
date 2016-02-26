import UIKit
import MapKit

class RunMapOverlay: NSObject, MKOverlay {
    var coordinate: CLLocationCoordinate2D
    var boundingMapRect: MKMapRect
    
    init(track: IBNewRunViewController) {
        boundingMapRect = track.overlayBoundingMapRect
        coordinate = track.midCoordinate
    }
}