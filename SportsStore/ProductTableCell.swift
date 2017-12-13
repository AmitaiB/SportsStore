//
//  TableViewCell.swift
//  SportsStore
//
//  Created by Amitai Blickstein on 12/13/17.
//  Copyright © 2017 Amitai Blickstein. All rights reserved.
//

import UIKit

class ProductTableCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var stockStepper: UIStepper!
    @IBOutlet weak var stockField: UITextField!
}
