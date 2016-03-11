import UIKit
import MapKit

class AttractionAnnotationView: MKAnnotationView {
    // Required for MKAnnotationView
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Called when drawing the AttractionAnnotationView
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        /*let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        */
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        
        
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))//imageView.bounds.size)
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        let imageView: UIImageView = UIImageView(image: newImage)
        var layer: CALayer = CALayer()
        layer = imageView.layer
        
        layer.masksToBounds = true
        layer.cornerRadius = CGFloat(newImage.size.width/2)
        
        UIGraphicsBeginImageContext(imageView.bounds.size)
        layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //now add pin to background
        let mapPin = UIImage(named: "Map_pin55X75.png")
        let finalSize = CGSize(width: 55, height: 150)
        UIGraphicsBeginImageContext(finalSize)
        
        //let areaSize = CGRect(x: 0, y: 0, width: finalSize.width, height: finalSize.height)
        mapPin!.drawInRect(CGRectMake(0, 0, finalSize.width, 75))
        roundedImage!.drawInRect(CGRectMake(finalSize.width/2-newWidth/2, 8, newWidth, newHeight))//(areaSize)
        
        let finalImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return finalImage
        /*
        let imageView: UIImageView = UIImageView(image: newImage)
        var layer: CALayer = CALayer()
        layer = imageView.layer
        layer.masksToBounds = true
        layer.cornerRadius = CGFloat(10)//image.size.width/2)
        layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return roundedImage*/
    }
    
    override init(annotation: MKAnnotation!, reuseIdentifier: String!) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        let attractionAnnotation = self.annotation as! AttractionAnnotation
        switch (attractionAnnotation.type) {
        case .AttractionFirstAid:
            image = UIImage(named: "firstaid")
        case .AttractionFood:
            image = UIImage(named: "food")
        case .AttractionWater:
            image = UIImage(named: "water")
        case .ProfilePicture:
            image = resizeImage(FacebookImages.sharedInstance.dictionaryOfProfilePictures[attractionAnnotation.desc!]!, newWidth: 40)
        default:
            image = UIImage(named: "star")
        }
    }

}