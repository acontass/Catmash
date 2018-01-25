//
//  ViewController.swift
//  Catmash
//
//  Created by acontass on 25/01/2018.
//  Copyright © 2018 acontass. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var vsImage: UIImageView!
    @IBOutlet weak var bottomImageView: UIImageView!
    
    private var displayedCats = (top: 0, bottom: 1)
    private var marks: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 0..<4 {
            marks.append(0)
        }
//        for idx in 0...1
//        let top = UICustomView(position: .top)
//        top.image = UIImage(named: "0")
//        view.insertSubview(top, belowSubview: vsImage)
//        let bottom = UICustomView(position: .bottom)
//        bottom.image = UIImage(named: "1")
//        view.insertSubview(bottom, belowSubview: vsImage)


/*        let separator = CutView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height / 2 + 32 - 7, width: UIScreen.main.bounds.width, height: 14))
        view.insertSubview(separator, belowSubview: vsImage)*/
    }
    
    private func updateImages() {
        let topIdx = arc4random_uniform(3)
        topImageView.image = UIImage(named: "\(topIdx)")
        
        var bottomIdx = arc4random_uniform(3)
        while (topIdx == bottomIdx) {
            bottomIdx = arc4random_uniform(3)
        }
        bottomImageView.image = UIImage(named: "\(bottomIdx)")
        displayedCats = (Int(topIdx), Int(bottomIdx))
//        print(marks)
    }
    
    @IBAction func topImageTouched(_ sender: UITapGestureRecognizer) {
        marks[displayedCats.top] += 1
        updateImages()
    }

    @IBAction func bottomImageTouched(_ sender: UITapGestureRecognizer) {
        marks[displayedCats.bottom] += 1
        updateImages()
    }
    
}

