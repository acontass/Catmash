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
    
    /// The cat image view at top of the view.
    
    @IBOutlet weak var topImageView: UIImageView!

    /// The cat image view at top of the view.
    
    @IBOutlet weak var bottomImageView: UIImageView!
    
    /// Current displayed cats.
    
    private var displayedCats = (top: -1, bottom: -1)
    
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
                            debugPrint(cat["url"] as! String)
                            do {
                                let imgData = try Data(contentsOf: URL(string: cat["url"] as? String ?? "")!)
                                Cat.all.append(Cat(image: UIImage(data: imgData), index: idx))
                                if idx == 1 {
                                    DispatchQueue.main.async {
                                        self.updateImages()
                                    }
                                }
                                idx += 1
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
     */
    
    private func updateImages() {
        let topIdx = arc4random_uniform(UInt32(Cat.all.count) - 1)
        var bottomIdx = arc4random_uniform(UInt32(Cat.all.count) - 1)
        while (topIdx == bottomIdx) {
            bottomIdx = arc4random_uniform(UInt32(Cat.all.count) - 1)
        }
        topImageView.image = Cat.all[Int(topIdx)].image
        bottomImageView.image = Cat.all[Int(bottomIdx)].image
        displayedCats = (Int(topIdx), Int(bottomIdx))
        
        topImageView.alpha = 0
        bottomImageView.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.topImageView.alpha = 1
            self.bottomImageView.alpha = 1
        }
    }
    
    @IBAction func topImageTouched(_ sender: UITapGestureRecognizer) {
        guard displayedCats.top != -1 else {
            return
        }
        Cat.all[displayedCats.top].upVote()
        updateImages()
    }

    @IBAction func bottomImageTouched(_ sender: UITapGestureRecognizer) {
        guard displayedCats.bottom != -1 else {
            return
        }
        Cat.all[displayedCats.top].upVote()
        updateImages()
    }
    
    @IBAction func profileButtonTouched(_ sender: UIBarButtonItem) {
        let alert = Tools.createAlert(title: nil, message: "This part is not yet implemented.", buttons: "Ok", completion: nil)
        present(alert, animated: true, completion: nil)
    }
    
}

