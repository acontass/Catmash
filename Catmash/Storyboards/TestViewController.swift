//
//  TestViewController.swift
//  Catmash
//
//  Created by acontass on 26/01/2018.
//  Copyright © 2018 acontass. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let top = UICuttedImageView(position: .top)
        top.image = Cat.all.first?.image
        view.addSubview(top)

        let bottom = UICustomView(position: .bottom)
        bottom.image = Cat.all.last?.image
        view.addSubview(bottom)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
