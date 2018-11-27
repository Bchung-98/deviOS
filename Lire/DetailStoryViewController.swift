//
//  DetailStoryViewController.swift
//  Lire
//
//  Created by ManGart on 25/11/2018.
//  Copyright © 2018 ManGart. All rights reserved.
//

import UIKit

class DetailStoryViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UITextView!
    
    var story: Story!
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = story.titre
        contentLabel.text = story.contenu
    }
}
