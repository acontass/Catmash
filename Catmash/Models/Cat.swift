//
//  Cat.swift
//  Catmash
//
//  Created by acontass on 25/01/2018.
//  Copyright © 2018 acontass. All rights reserved.
//

import UIKit

/// Cat model.

class Cat {
    
    /// All cats in array of Cat instances (initialized only at first call).
    
    static public let all: [Cat] = {
        var cats = [Cat]()
        for idx in 0..<8 {
            cats.append(Cat(image: UIImage(named: "\(idx)")))
        }
        return cats
    }()
    
    /// Picture of the cat.
    
    public let image: UIImage?
    
    /// Mark of the cat.
    
    public private(set) var mark: Int = 0
    
    /**
     Initializer of Cat.
     
     - parameter image: Optional size of the image (default is navigation bar size).
     */
    
    init(image: UIImage?) {
        self.image = image
    }
    
    /**
     Up vote mark of the cat.
     
     - returns: Nothing.
    */
    
    public func upVote() {
        mark += 1
    }
    
}
