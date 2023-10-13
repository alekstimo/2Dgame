//
//  Sources.swift
//  Aston2DGame
//
//  Created by Александра Тимонова on 19.09.2023.
//

import Foundation
import UIKit
extension CGFloat {

    static let offset10 = 10.0
    static let offset24 = 24.0
    static let offset100 = 100.0
    static let offset240 = 240.0
   
}
struct Colors {
    static let yellowColor: UIColor = UIColor(named: "yellowFontColor") ?? .yellow
    static let orangeColor: UIColor = UIColor(named: "orangeFontColor") ?? .orange
    static let darkVioletColor: UIColor = UIColor(named: "backgroundColor") ?? .systemBlue
    static let purpleColor: UIColor = UIColor(named: "purpleColor") ?? .purple
    static let lightPinkColor: UIColor = UIColor(named: "lightPinkColor") ?? .systemPink
    static let backgroundLightColor: UIColor = UIColor(named: "backgroundLightColor") ?? .systemPink
}
struct ImagesNames {
    static let leftArrowButton: String = "leftArrow"
    static let rightArrowButton: String = "rightArrow"
    static let star: String = "star"
    static let meteor: String = "meteorite"
}

func resizeImage(image: UIImage?, targetSize: CGSize) -> UIImage {
    guard let image = image else { return UIImage()}
        let size = image.size

        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }

extension UILabel {
    convenience init(text: String, font: UIFont, color: UIColor){
        self.init()
        self.text =  text
        self.textColor = color
        self.font = font
    }
}
