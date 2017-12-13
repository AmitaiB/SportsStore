//
//  ViewController.swift
//  SportsStore
//
//  Created by Amitai Blickstein on 12/13/17.
//  Copyright © 2017 Amitai Blickstein. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    // p.37
    @IBOutlet weak var totalStockLabel: UILabel!
    
    // p.44
    @IBOutlet weak var tableView: UITableView!
    
    // p.29
    var products = [
        ("Kayak", "A boat for one person", "Watersports", 275.0, 10),
        ("Lifejacket", "Protective and fashionable", "Watersports", 48.95, 14),
        ("Soccer Ball", "FIFA-approved size and weight", "Soccer", 19.5, 32),
        ("Corner Flags", "Give your playing field a professional touch", "Soccer", 34.95, 1),
        ("Stadium", "Flat-packed 35,000-seat stadium", "Soccer", 79500.0, 4),
        ("Thinking Cap", "Improve your brain effciency by 75%", "Chess", 16.0, 8),
        ("Unsteady Chair", "Secretly give your opponent a disadvantage", "Chess", 29.95, 3),
        ("Human Chess Board", "A fun game for the family", "Chess", 75.0, 2),
        ("Bling-Bling King", "Gold-plated, diamond studded King", "Chess", 1200.0, 4)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayTotalStock()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // p.39
    func displayTotalStock() {
        let stockTotal = products.reduce(0) { total, product in
            return total + product.4
        }
        totalStockLabel.text = "\(stockTotal) Products in Stock"
    }
    
    
    // p.47
    @IBAction func stockLevelDidChange(_ sender: Any) {
        if var currentCell = sender as? UIView {
            while (true) {
                currentCell = currentCell.superview!
                if let cell = currentCell as? ProductTableCell {
                    if let id = cell.productId {
                        
                        var newStockLevel: Int?
                        
                        if let stepper = sender as? UIStepper {
                            newStockLevel = Int(stepper.value)
                        } else if
                            let textfield = sender as? UITextField,
                            let text = textfield.text {
                                if let newValue = Int(text) {
                                    newStockLevel = newValue
                            }
                        }
                        
                        if let level = newStockLevel {
                            products[id].4 = level
                            cell.stockStepper.value = Double(level)
                            cell.stockField.text = String(level)
                        }
                    }
                    break
                }
            }
            displayTotalStock()
        }
    }
    
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = products[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
        
        if let cell = cell as? ProductTableCell {
            cell.productId = indexPath.row // p.49
            cell.nameLabel.text = product.0
            cell.descriptionLabel.text = product.1
            cell.stockStepper.value = Double(product.4)
            cell.stockField.text = "\(product.4)"
        }
        
        return cell
    }
    
}
