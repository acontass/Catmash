//
//  CatTableViewCell.swift
//  Catmash
//
//  Created by acontass on 25/01/2018.
//  Copyright © 2018 acontass. All rights reserved.
//

import UIKit

class CatTableViewCell: UITableViewCell {
    
    private enum eSide: Int {
        case left = 0,
        right
    }

    @IBOutlet var imageViewCollection: [UIImageView]!
    @IBOutlet var labelsCollection: [UILabel]!
    
    public var cats: (Cat, Cat)? = nil {
        didSet {
            if let cats = cats {
                imageViewCollection[eSide.left.rawValue].image = cats.0.image
                labelsCollection[eSide.left.rawValue].text = "\(cats.0.mark) vote"
                imageViewCollection[eSide.right.rawValue].image = cats.1.image
                labelsCollection[eSide.right.rawValue].text = "\(cats.1.mark) vote"
            }
        }
    }

}
