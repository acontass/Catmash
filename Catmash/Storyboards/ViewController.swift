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
    
    /**
     Make the url request and initialize all cats.
     
     - returns: Nothing.
     */
    
    private func setAllCats() {
        if let url = URL(string: "https://latelier.co/data/cats.json".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) {
            let request = NSMutableURLRequest(url: url)
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        let alert = Tools.createAlert(title: "Error", message: error.localizedDescription, buttons: "Cancel", completion: nil)
                        self.present(alert, animated: true, completion: nil)
                        return
                    }
                }
                if let unwrappedData = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as! NSDictionary
                        var idx = 0
                        for cat in json["images"] as? [NSDictionary] ?? [] {
                            do {
                                let imgData = try Data(contentsOf: URL(string: cat["url"] as? String ?? "")!)
                                DispatchQueue.main.async {
                                Cat.all.append(Cat(image: UIImage(data: imgData), index: idx))
                                if idx == 0 {
                                    self.displayedCats.top = idx
                                    self.updateImage(keep: .bottom)
                                }
                                else if idx == 1 {
                                    self.displayedCats.bottom = idx
                                    self.updateImage(keep: .top)
                                }
                                idx += 1
                                }
                            }
                            catch let error {
                                debugPrint(error.localizedDescription)
                            }
                        }
                    }
                    catch let error {
                        let alert = Tools.createAlert(title: "Erreur", message: error.localizedDescription, buttons: "Cancel", completion: nil)
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
            task.resume()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setAllCats()
        
        // TODO: This is proper way to make cutted image views. (Not yet finished)
        
//        for idx in 0...1
//        let top = UICustomView(position: .top)
//        top.image = UIImage(named: "0")
//        view.insertSubview(top, belowSubview: vsImage)
//        let bottom = UICustomView(position: .bottom)
//        bottom.image = UIImage(named: "1")
//        view.insertSubview(bottom, belowSubview: vsImage)
//        updateImages()
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
    
    @IBAction func profileButtonTouched(_ sender: UIBarButtonItem) {
        let alert = Tools.createAlert(title: nil, message: "This part is not yet implemented.", buttons: "Ok", completion: nil)
        present(alert, animated: true, completion: nil)
    }
    
}

