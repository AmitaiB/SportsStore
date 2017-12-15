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
        Product(name: "Kayak", description: "A boat for one person", category: "Watersports", price: 275.0, stock: 10),
        Product(name: "Lifejacket", description: "Protective and fashionable", category: "Watersports", price: 48.95, stock: 14),
        Product(name: "Soccer Ball", description: "FIFA-approved size and weight", category: "Soccer", price: 19.5, stock: 32),
        Product(name: "Corner Flags", description: "Give your playing field a professional touch", category: "Soccer", price: 34.95, stock: 1),
        Product(name: "Stadium", description: "Flat-packed 35,000-seat stadium", category: "Soccer", price: 79500.0, stock: 4),
        Product(name: "Thinking Cap", description: "Improve your brain effciency by 75%", category: "Chess", price: 16.0, stock: 8),
        Product(name: "Unsteady Chair", description: "Secretly give your opponent a disadvantage", category: "Chess", price: 29.95, stock: 3),
        Product(name: "Human Chess Board", description: "A fun game for the family", category: "Chess", price: 75.0, stock: 2),
        Product(name: "Bling-Bling King", description: "Gold-plated, diamond studded King", category: "Chess", price: 1200.0, stock: 4)
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
        let stockTotal = products.reduce(0) { (total, product) in
            return total + product.stock
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
                            products[id].stock = level
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
            cell.nameLabel.text = product.name
            cell.descriptionLabel.text = product.description
            cell.stockStepper.value = Double(product.stock)
            cell.stockField.text = "\(product.stock)"
        }
        
        return cell
    }
    
}
