//
//  CutView.swift
//  Catmash
//
//  Created by acontass on 25/01/2018.
//  Copyright © 2018 acontass. All rights reserved.
//

import UIKit

class CutView: UIView {
    
    /// Offset of cutted view.
    
    @IBInspectable private var offset: CGFloat = 8
    
    /**
     Initializer of the view.
     
     - parameter frame: The frame of the view.
     */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }
    
    /**
     Initializer by storyboard.
     
     - parameter size: Optional size of the image (default is navigation bar size).
     */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = .clear
    }
    
    /**
     Draw the cutted view in current context.
     
     - returns: Nothing.
     
     - parameter frame: The frame of the view.
     */

    override func draw(_ rect: CGRect) {
        let points = [CGPoint(x: rect.origin.x, y: rect.origin.y + offset),
                      CGPoint(x: rect.width, y: rect.origin.y),
                      CGPoint(x: rect.width, y: rect.height - offset),
                      CGPoint(x: rect.origin.x, y: rect.height)]
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        context?.setStrokeColor(UIColor.black.cgColor)
        context?.addLines(between: points)
        context?.closePath()
        context?.setFillColor(UIColor.white.cgColor)
        context?.fillPath()
        context?.restoreGState()
    }

}
