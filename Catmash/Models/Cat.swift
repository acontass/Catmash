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

    // MARK: Static part.

    /// All cats in array of Cat instances (initialized only at first call).

    static public private(set) var all = [Cat]()

    /// Total cats count.

    static public private(set) var total = 0

    /// All cats identifiers.

    static public private(set) var ids = [String]()

    /**
     Load all pictures of cats.

     - returns: Nothing.

     - parameter json: The json data of the cats request.
     */

    static private func loadCatsPictures(_ json: NSDictionary) {
        guard let images = json["images"] as? [NSDictionary] else {
            return
        }
        total = images.count
        images.forEach() { cat in
            do {
                let imgData = try Data(contentsOf: URL(string: cat["url"] as? String ?? "")!)
                DispatchQueue.main.async {
                    Cat.all.append(Cat(image: UIImage(data: imgData), id: cat["id"] as? String))
                    if Cat.all.count == 1 {
                        NotificationCenter.default.post(name: NotificationsManager.didLoadCat, object: self, userInfo: ["position": "top"])
                    }
                    else if Cat.all.count == 2 {
                        NotificationCenter.default.post(name: NotificationsManager.didLoadCat, object: self, userInfo: ["position": "bottom"])
                    }
                    if Cat.all.count >= total {
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    }
                }
            }
            catch let error {
                total -= 1
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    /**
     Make the url request and initialize all cats.
     
     - returns: Nothing.
     
     - parameter controller: The current view controller used to display errors alerts.
     */
    
    static public func loadAllCats(on controller: UIViewController? = nil) {
        if let url = URL(string: "https://latelier.co/data/cats.json".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
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
                        loadCatsPictures(json)
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

    static public var allDisplayed: Bool {
        get {
            for cat in all {
                if !cat.displayed {
                    return false
                }
            }
            return (all.count >= total) ? true : false
        }
    }

    static public func getNoDisplayedCat() -> Cat? {
        for cat in all {
            if !cat.displayed {
                cat.displayed = true
                return cat
            }
        }
        return nil
    }
    
/*    /// index of the cat.

    private let index: Int!*/
    
    /// Picture of the cat.

    public let image: UIImage?
    
    /// Mark of the cat.
    
    public private(set) var mark: Int = 0
    
    /// The id of the cat.
    
    public let id: String?

    /// True if cat allready displayed.

    fileprivate var displayed = false
    
    /**
     Initializer of Cat.
     
     - parameter image: Optional size of the image (default is navigation bar size).
     - parameter index: The index of the cat in all cats array.
     */
    
    init(image: UIImage?, id: String?) {
        self.image = image
//        self.index = index
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
