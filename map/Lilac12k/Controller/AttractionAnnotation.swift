import UIKit
import MapKit

enum AttractionType: Int {
    case AttractionDefault = 0
    case AttractionRide = 1
    case AttractionFood = 2
    case AttractionFirstAid = 3
    case ProfilePicture = 4
    case AttractionWater = 5
}

class AttractionAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var type: AttractionType
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, type: AttractionType) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.type = type
        
    }
}