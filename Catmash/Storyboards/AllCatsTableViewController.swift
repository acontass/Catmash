//
//  AllCatsTableViewController.swift
//  Catmash
//
//  Created by acontass on 25/01/2018.
//  Copyright © 2018 acontass. All rights reserved.
//

import UIKit

class AllCatsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        tableView.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    @objc internal func refresh() {
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Cat.all.count / 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatCell", for: indexPath) as! CatTableViewCell
        cell.cats = (Cat.all[indexPath.row], Cat.all[indexPath.row % Cat.all.count + Cat.all.count / 2])
        return cell
    }

}
