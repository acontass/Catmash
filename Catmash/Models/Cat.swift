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
    
    static public var all = [Cat]()/* = {
        var cats = [Cat]()
        for idx in 0..<8 {
            cats.append(Cat(image: UIImage(named: "\(idx)")))
        }
        return cats
    }()*/
    
    /// Picture of the cat.
    
    private let index: Int!
    
    public let image: UIImage?
    
    /// Mark of the cat.
    
    public private(set) var mark: Int = 0
    
/*    lazy var id: String = {
        return <#value#>
    }()*/
    
    /**
     Initializer of Cat.
     
     - parameter image: Optional size of the image (default is navigation bar size).
     - parameter index: The index of the cat in all cats array.
     */
    
    init(image: UIImage?, index: Int) {
        self.image = image
        self.index = index
    }
    
    /**
     Up vote mark of the cat.
     
     - returns: Nothing.
    */
    
    public func upVote() {
        mark += 1
    }
    
}
