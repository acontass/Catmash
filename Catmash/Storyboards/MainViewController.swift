//
//  MainViewController.swift
//  Catmash
//
//  Created by acontass on 25/01/2018.
//  Copyright © 2018 acontass. All rights reserved.
//

import UIKit

/// Home view of the application.

class MainViewController: UIViewController {

    /**
     Enumeration of the image positions in the view.

     ```
     case top = 0,
     bottom
     ```
     */
    
    private enum ePosition: Int {
        case top = 0,
        bottom
    }
    
    /// The cat image view at top of the view.
    
    @IBOutlet weak var topImageView: UIImageView!

    /// The cat image view at top of the view.
    
    @IBOutlet weak var bottomImageView: UIImageView!

    /// Current displayed cats.

    private var displayedCats: (top: Cat?, bottom: Cat?) = (nil, nil)

    /// The image view that contain the winner at end.

    private var winnerImageView: UIImageView?

    /// The action called when first or second picture of cats are load.
    
    @objc internal func didLoadCat(_ notification: Notification) {
        if let position = notification.userInfo?.values.first as? String {
            (position == "top") ? updateImage(keep: .bottom) : updateImage(keep: .top)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(didLoadCat(_:)), name: NotificationsManager.didLoadCat, object: nil)

        let topMask = UIImageView(image: #imageLiteral(resourceName: "Rectangle"))
        topMask.contentMode = .scaleToFill
        let height = (UIScreen.main.bounds.height - 64) / 2 + 20.5
        topMask.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height)
        topImageView.mask = topMask

        let bottomMask = UIImageView(image: #imageLiteral(resourceName: "RectangleReverse"))
        bottomMask.contentMode = .scaleToFill
        bottomMask.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: height)
        bottomImageView.mask = bottomMask
    }

    /// Fade animation.

    private func animateImageAppears(_ view: UIView) {
        view.alpha = 0
        UIView.animate(withDuration: 0.5) {
            view.alpha = 1
        }
    }

    /**
     Display new cats.
     
     - returns: Nothing.
     
     - parameter keep: Keep top or bottom image.
     */
    
    private func updateImage(keep: ePosition) {
        guard !Cat.allDisplayed else {
            winnerImageView = UIImageView(frame: CGRect.zero)
            winnerImageView?.contentMode = .scaleAspectFit
            winnerImageView?.backgroundColor = .white
            var cat: Cat?
            Cat.all.forEach {
                if $0.mark > cat?.mark ?? 0 {
                    cat = $0
                }
            }
            winnerImageView?.image = cat?.image
            view.addSubview(winnerImageView!)
            UIView.animate(withDuration: 0.5) {
                self.winnerImageView?.frame = CGRect(origin: CGPoint(x: 0, y: 64), size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64))
            }
            let button = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTouched))
            navigationItem.setLeftBarButton(button, animated: true)
            return
        }
        guard let new = Cat.getNoDisplayedCat() else {
            let alert = Tools.createAlert(title: "Please be patient", message: "The cat picture is downloading.", buttons: "Ok", completion: nil)
            present(alert, animated: true, completion: nil)
            return
        }
        if keep == .top {
            displayedCats.bottom = new
            bottomImageView.image = displayedCats.bottom?.image
            animateImageAppears(bottomImageView)
        }
        else {
            displayedCats.top = new
            topImageView.image = displayedCats.top?.image
            animateImageAppears(topImageView)
        }
    }

    @IBAction func skipTouched() {
        guard displayedCats.bottom != nil && displayedCats.top != nil else {
            return
        }
        updateImage(keep: .bottom)
        updateImage(keep: .top)
    }

    /// The action when the top left button is touched (only when the winner is displayed)

    @objc internal func refreshTouched() {
        Cat.reloadCats()
        UIView.animate(withDuration: 0.5, animations: {
            self.winnerImageView?.alpha = 0
        }) { _ in
            self.winnerImageView?.removeFromSuperview()
            self.winnerImageView = nil
        }
        let button = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(skipTouched))
        navigationItem.setLeftBarButton(button, animated: true)
    }

    /// The action called when the top picture is touched.
    
    @IBAction func topImageTouched(_ sender: UITapGestureRecognizer) {
        guard displayedCats.top != nil, winnerImageView == nil else {
            return
        }
        displayedCats.top?.upVote()
        updateImage(keep: .top)
    }

    /// The action called when the bottom picture is touched.

    @IBAction func bottomImageTouched(_ sender: UITapGestureRecognizer) {
        guard displayedCats.bottom != nil && winnerImageView == nil else {
            return
        }
        displayedCats.bottom?.upVote()
        updateImage(keep: .bottom)
    }
    
}

