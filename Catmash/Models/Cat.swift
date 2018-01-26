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
    
    /**
     Make the url request and initialize all cats.
     
     - returns: Nothing.
     
     -parameter controller: The current view controller used to display errors alerts.
     */
    
    static public func loadAllCats(on controller: UIViewController? = nil) {
        if let url = URL(string: "https://latelier.co/data/cats.json".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) {
            let request = NSMutableURLRequest(url: url)
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        let alert = Tools.createAlert(title: "Error", message: error.localizedDescription, buttons: "Cancel", completion: nil)
                        controller?.present(alert, animated: true, completion: nil)
                        return
                    }
                }
                if let unwrappedData = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as! NSDictionary
                        var idx = 0
                        (json["images"] as? [NSDictionary] ?? []).forEach() { cat in
                            do {
                                let imgData = try Data(contentsOf: URL(string: cat["url"] as? String ?? "")!)
                                DispatchQueue.main.async {
                                    Cat.all.append(Cat(image: UIImage(data: imgData), index: idx, id: cat["id"] as? String))
//                                    print(Cat.all.last)
                                    if idx == 0 {
                                        NotificationCenter.default.post(name: NotificationsManager.didLoadCat, object: self, userInfo: ["position": "top"])
//                                        self.displayedCats.top = idx
//                                        self.updateImage(keep: .bottom)
                                    }
                                    else if idx == 1 {
                                        NotificationCenter.default.post(name: NotificationsManager.didLoadCat, object: self, userInfo: ["position": "bottom"])
//                                        self.displayedCats.bottom = idx
//                                        self.updateImage(keep: .top)
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
                        controller?.present(alert, animated: true, completion: nil)
                    }
                }
            }
            task.resume()
        }
    }
    
    /// All cats in array of Cat instances (initialized only at first call).
    
    static public private(set) var all = [Cat]()
    
    /// Picture of the cat.
    
    private let index: Int!
    
    public let image: UIImage?
    
    /// Mark of the cat.
    
    public private(set) var mark: Int = 0
    
    /// The id of the cat.
    
    public let id: String?
    
    /**
     Initializer of Cat.
     
     - parameter image: Optional size of the image (default is navigation bar size).
     - parameter index: The index of the cat in all cats array.
     */
    
    init(image: UIImage?, index: Int, id: String?) {
        self.image = image
        self.index = index
        self.id = id
    }
    
    /**
     Up vote mark of the cat.
     
     - returns: Nothing.
    */
    
    public func upVote() {
        mark += 1
    }
    
}
