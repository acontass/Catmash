//
//  CatTableViewCell.swift
//  Catmash
//
//  Created by acontass on 25/01/2018.
//  Copyright © 2018 acontass. All rights reserved.
//

import UIKit

/// Cell of cat.

class CatTableViewCell: UITableViewCell {
    
    /**
     enumeration of pictures in the cell.
     
     ```
     case left = 0,
     right
     ```
     */
    
    private enum eSide: Int {
        case left = 0,
        right
    }

    /// All image views of the cell.
    
    @IBOutlet var imageViewCollection: [UIImageView]!

    /// All labels of the cell.
    
    @IBOutlet var labelsCollection: [UILabel]!
    
    /// The two cats to display in the cell.
    
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
