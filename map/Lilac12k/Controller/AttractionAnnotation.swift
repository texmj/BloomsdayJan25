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
    var desc: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, type: AttractionType) {
        self.coordinate = coordinate
        self.title = title
        self.type = type
        self.desc = nil
        self.subtitle = subtitle
    }
    init(coordinate: CLLocationCoordinate2D, title: String, desc: String, type: AttractionType) {
        self.coordinate = coordinate
        self.title = title
        self.type = type
        if(type == AttractionType(rawValue: 4))
        {
            self.desc = desc
        }
        self.subtitle = nil
    }
}