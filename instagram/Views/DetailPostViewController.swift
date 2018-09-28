//
//  DetailPostViewController.swift
//  instagram
//
//  Created by Andre Campbell on 9/28/18.
//  Copyright © 2018 Andre Campbell. All rights reserved.
//

import UIKit

class DetailPostViewController: UIViewController {

    @IBOutlet weak var captionLabel: UILabel!
    var caption: String!
    var timestamp: String!
    @IBOutlet weak var timestampLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        captionLabel.text = caption
        timestampLabel.text = timestamp

        // Do any additional setup after loading the view.
    }
    
}
