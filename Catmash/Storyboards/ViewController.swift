//
//  ViewController.swift
//  Catmash
//
//  Created by acontass on 25/01/2018.
//  Copyright © 2018 acontass. All rights reserved.
//

import UIKit

/// Home view of the application.

class ViewController: UIViewController {
    
    private enum ePosition: Int {
        case top = 0,
        bottom
    }
    
    /// The cat image view at top of the view.
    
    @IBOutlet weak var topImageView: UIImageView!

    /// The cat image view at top of the view.
    
    @IBOutlet weak var bottomImageView: UIImageView!
    
    /// Current displayed cats.
    
    private var displayedCats = (top: -1, bottom: -1)
    
    @objc internal func didLoadCat(_ notification: Notification) {
        if let position = notification.userInfo?.values.first as? String {
            print(position)
            if position == "top" {
                
                displayedCats.top = 0
                updateImage(keep: .bottom)
/*                let top = UICustomView(position: .top)
//                top.image = Cat.all.first?.image
                view.addSubview(top)*/
            }
            else {
                displayedCats.bottom = 1
                updateImage(keep: .top)

/*                let bottom = UICustomView(position: .bottom)
                bottom.image = Cat.all.last?.image
                view.addSubview(bottom)*/
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(didLoadCat(_:)), name: NotificationsManager.didLoadCat, object: nil)
    }
    
    /**
     Display new cats.
     
     - returns: Nothing.
     
     - parameter keep: Keep top or bottom image.
     - parameter add: Boolean that indicates if it would increment the index of the picture to change.
     */
    
    private func updateImage(keep: ePosition, add: Bool = false) {
        if add && max(displayedCats.top, displayedCats.bottom) + 1 >= Cat.all.count {
            let alert = Tools.createAlert(title: "Be patient", message: "The image is downloading", buttons: "Ok", completion: nil)
            present(alert, animated: true, completion: nil)
            return
        }
        if keep == .top {
            if displayedCats.bottom > -1 {
                if add {
                    displayedCats.bottom = max(displayedCats.top, displayedCats.bottom) + 1
                }
                bottomImageView.image = Cat.all[displayedCats.bottom].image
            }
            bottomImageView.alpha = 0
            UIView.animate(withDuration: 0.5) {
                self.bottomImageView.alpha = 1
            }
        }
        else {
            if displayedCats.top > -1 {
                if add {
                    displayedCats.top = max(displayedCats.top, displayedCats.bottom) + 1
                }
                topImageView.image = Cat.all[displayedCats.top].image
            }
            topImageView.alpha = 0
            UIView.animate(withDuration: 0.5) {
                self.topImageView.alpha = 1
            }
        }
    }
    
    @IBAction func topImageTouched(_ sender: UITapGestureRecognizer) {
        guard displayedCats.top != -1 else {
            return
        }
        Cat.all[displayedCats.top].upVote()
        updateImage(keep: .top, add: true)
    }

    @IBAction func bottomImageTouched(_ sender: UITapGestureRecognizer) {
        guard displayedCats.bottom != -1 else {
            return
        }
        Cat.all[displayedCats.bottom].upVote()
        updateImage(keep: .bottom, add: true)
    }
    
}

