//
//  UIColorExtension.swift
//  Catmash
//
//  Created by acontass on 25/01/2018.
//  Copyright © 2018 acontass. All rights reserved.
//

import UIKit

/// All custom colors used in the application.

extension UIColor {
    
    /**
     Custom initilizer of color.
     
     - parameter r: red color between 0 and 255.
     - parameter g: green color between 0 and 255.
     - parameter b: blue color between 0 and 255.
     - parameter a: Optionnal parameter. Alpha between 0 and 1, default is 1.
     */
    
    convenience init(r: Int, g: Int, b: Int, a: CGFloat = 1) {
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: a)
    }
    
    /// Main red color of the application (see navigation bar)
    
    static let mainRed = UIColor(r: 206, g: 11, b: 36)
    
    /**
     Create image with color.
     
     - returns: An UIImage of the color.
     
     - parameter size: Optional size of the image (default is navigation bar size).
     */
    
    public func image(_ size: CGSize = CGSize(width: UIScreen.main.bounds.width, height: 64)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        }
    }
}
