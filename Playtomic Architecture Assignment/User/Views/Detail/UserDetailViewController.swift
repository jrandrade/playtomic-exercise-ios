//
//  UserDetailViewController.swift
//  Playtomic Architecture Assignment
//
//  Created by Angel Luis Garcia on 11/02/2020.
//  Copyright © 2020 Playtomic. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!

    var user: User! {
        didSet {
            loadViewIfNeeded()
            nameLabel.text = user.name
        }
    }
}

