//
//  Cat.swift
//  Catmash
//
//  Created by acontass on 25/01/2018.
//  Copyright © 2018 acontass. All rights reserved.
//

import UIKit

class Cat {
    
    static public let all: [Cat] = {
        var cats = [Cat]()
        for idx in 0..<Constants.catsCount {
            cats.append(Cat(image: UIImage(named: "\(idx)")))
        }
        return cats
    }()
    
    public let image: UIImage?
    
    public private(set) var mark: Int = 0
    
    init(image: UIImage?) {
        self.image = image
    }
    
    public func upVote() {
        mark += 1
    }
    
}
