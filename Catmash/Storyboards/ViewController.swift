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

    override func viewDidLoad() {
        super.viewDidLoad()
//        for idx in 0...1
//        let top = UICustomView(position: .top)
//        top.image = UIImage(named: "0")
//        view.insertSubview(top, belowSubview: vsImage)
//        let bottom = UICustomView(position: .bottom)
//        bottom.image = UIImage(named: "1")
//        view.insertSubview(bottom, belowSubview: vsImage)
    }
    
    private func updateImages() {
        let topIdx = arc4random_uniform(Constants.catsCount - UInt32(1))
        topImageView.image = UIImage(named: "\(topIdx)")
        
        var bottomIdx = arc4random_uniform(Constants.catsCount - UInt32(1))
        while (topIdx == bottomIdx) {
            bottomIdx = arc4random_uniform(Constants.catsCount - UInt32(1))
        }
        bottomImageView.image = UIImage(named: "\(bottomIdx)")
        displayedCats = (Int(topIdx), Int(bottomIdx))
        
        topImageView.alpha = 0
        bottomImageView.alpha = 0
        UIView.animate(withDuration: 1) {
            self.topImageView.alpha = 1
            self.bottomImageView.alpha = 1
        }
    }
    
    @IBAction func topImageTouched(_ sender: UITapGestureRecognizer) {
        Cat.all[displayedCats.top].upVote()
        updateImages()
    }

    @IBAction func bottomImageTouched(_ sender: UITapGestureRecognizer) {
        Cat.all[displayedCats.top].upVote()
        updateImages()
    }
    
    @IBAction func profileButtonTouched(_ sender: UIBarButtonItem) {
        let alert = Tools.createAlert(title: nil, message: "This part is not yet implemented.", buttons: "Ok", completion: nil)
        present(alert, animated: true, completion: nil)
    }
    
}

