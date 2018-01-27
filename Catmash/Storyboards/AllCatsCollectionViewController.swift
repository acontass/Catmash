//
//  AllCatsCollectionViewController.swift
//  Catmash
//
//  Created by Anthony CONTASSOT-VIVIER on 27/01/2018.
//  Copyright © 2018 acontass. All rights reserved.
//

import UIKit

/// Reuse identifier of the main cell.

private let reuseIdentifier = "Cell"

/// The collection view to display all loaded cats.

class AllCatsCollectionViewController: UICollectionViewController {

    /// Data of the collection view.

    private var sortedCats: [Cat]!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        let side = (UIScreen.main.bounds.width - 24) / 2
        let cellSize = CGSize(width: side , height: side + 25)

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
        layout.minimumInteritemSpacing = 8.0
        collectionView?.setCollectionViewLayout(layout, animated: false)
        sortedCats = Cat.all.sorted { $0.mark > $1.mark }

        collectionView?.refreshControl = UIRefreshControl()
        collectionView?.refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        collectionView?.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }

    @objc internal func refresh() {
        sortedCats = Cat.all.sorted { $0.mark > $1.mark }
        collectionView?.reloadData()
        collectionView?.refreshControl?.endRefreshing()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sortedCats.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)

        cell.contentView.subviews.forEach {
            $0.removeFromSuperview()
        }

        let size = CGSize(width: cell.contentView.frame.width, height: cell.contentView.frame.height - 25)
        let imageView = UIImageView(frame: CGRect(origin: cell.contentView.frame.origin, size: size))
        imageView.image = sortedCats[indexPath.row].image
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 4
        cell.contentView.addSubview(imageView)

        let label = UILabel(frame: CGRect(x: 0, y: cell.contentView.frame.height - 25, width: cell.contentView.frame.width, height: 25))
        label.textAlignment = .center
        label.text = "\(sortedCats[indexPath.row].mark) vote" + ((sortedCats[indexPath.row].mark > 1) ? "s" : "")
        cell.contentView.addSubview(label)

        return cell
    }

}
