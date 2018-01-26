//
//  UICustomView.swift
//  Catmash
//
//  Created by acontass on 25/01/2018.
//  Copyright © 2018 acontass. All rights reserved.
//

import UIKit

/// This class is not yet finished.

@IBDesignable
class UICustomView: UIView {
    
    enum ePosition: Int {
        case top = 0,
        bottom = 1
    }
    
    private var position: ePosition?
    private var imageView: UIImageView?
    
    @IBInspectable public var image: UIImage? = nil {
        didSet {
            if let image = image {
                if imageView == nil {
                    imageView = UIImageView(frame: self.bounds)
                    imageView?.contentMode = .scaleAspectFill
                    imageView?.clipsToBounds = true
                    addSubview(imageView!)
                }
                imageView?.image = image
            }
        }
    }
    
    convenience init(position: ePosition, image: UIImage? = nil) {
        let frame = (position == .top) ? CGRect(x: 0, y: 64, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2 - 32) : CGRect(x: 0, y: UIScreen.main.bounds.height / 2 + 32, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2 - 32)
        self.init(frame: frame)
        self.position = position
        backgroundColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Custom views are not yet available in Storyboard or Xib files.")
    }

    override func draw(_ rect: CGRect) {
        if let position = position {
            var points: [CGPoint]!
            if position == .top {
                points = [CGPoint(x: rect.origin.x, y: rect.origin.y),
                          CGPoint(x: rect.width, y: rect.origin.y),
                          CGPoint(x: rect.width, y: rect.height - 50),
                          CGPoint(x: rect.origin.x, y: rect.height)]
            }
            else {
                points = [CGPoint(x: rect.origin.x, y: rect.origin.y + 50),
                          CGPoint(x: rect.width, y: rect.origin.y),
                          CGPoint(x: rect.width, y: rect.height),
                          CGPoint(x: rect.origin.x, y: rect.height)]
            }
            let context = UIGraphicsGetCurrentContext()
            context?.saveGState()
            context?.setStrokeColor(UIColor.black.cgColor)
            context?.addLines(between: points)
            context?.closePath()
            context?.setFillColor((position == .top) ? UIColor.blue.withAlphaComponent(0.2).cgColor : UIColor.red.withAlphaComponent(0.2).cgColor)
            context?.fillPath()
            context?.restoreGState()
            
            let layer = CALayer()
//            layer.frame.
            layer.backgroundColor = UIColor.blue.cgColor
            self.layer.insertSublayer(layer, at: 0)
//            self.layer.mask = layer;
//            self.layer.masksToBounds = true;
        }
    }

}
