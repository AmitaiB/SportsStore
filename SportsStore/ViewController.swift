//
//  ViewController.swift
//  SportsStore
//
//  Created by Amitai Blickstein on 12/13/17.
//  Copyright © 2017 Amitai Blickstein. All rights reserved.
//

import UIKit

 fileprivate var handler = { (prod: Product) in
    print("Change: \(prod.name) \(prod.stockLevel) items in stock.")
}


class ViewController: UIViewController, UITableViewDataSource {
    // p.37
    @IBOutlet weak var totalStockLabel: UILabel!
    
    // p.44
    @IBOutlet weak var tableView: UITableView!
    
//    let logger = Logger<Product>(callback: handler)
    
    // p.29
    var products = [
        Product(name: "Kayak",        description: "A boat for one person", category: "Watersports", price: 275.0, stockLevel: 10),
        Product(name: "Lifejacket",   description: "Protective and fashionable", category: "Watersports", price: 48.95, stockLevel: 14),
        Product(name: "Soccer Ball",  description: "FIFA-approved size and weight", category: "Soccer", price: 19.5, stockLevel: 32),
        Product(name: "Corner Flags", description: "Give your playing field a professional touch", category: "Soccer", price: 34.95, stockLevel: 1),
        Product(name: "Stadium",      description: "Flat-packed 35,000-seat stadium", category: "Soccer", price: 79500.0, stockLevel: 4),
        Product(name: "Thinking Cap", description: "Improve your brain effciency by 75%", category: "Chess", price: 16.0, stockLevel: 8),
        Product(name: "Unsteady Chair", description: "Secretly give your opponent a disadvantage", category: "Chess", price: 29.95, stockLevel: 3),
        Product(name: "Human Chess Board", description: "A fun game for the family", category: "Chess", price: 75.0, stockLevel: 2),
        Product(name: "Bling-Bling King", description: "Gold-plated, diamond studded King", category: "Chess", price: 1200.0, stockLevel: 4)
    ]
    
    func calculateStockValue(productsArray: [Product]) -> Double {
        return productsArray.reduce(0) { (total, product) in
            return total + product.stockValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayTotalStock()
    }

    // p.39
    func displayTotalStock() {
        let finalTotals: (Int, Double) = products.reduce((0, 0.0)) { (totals, product) in
            return (
                totals.0 + product.stockLevel,
                totals.1 + product.stockValue
            )
        }
        
        totalStockLabel.text = """
        Total of \(finalTotals.0) Products in Stock.
        Total Value: \(Utils.currencyString(from: finalTotals.1)).
        """
    }
    
    
    // p.47
    @IBAction func stockLevelDidChange(_ sender: Any) {
        if var currentCell = sender as? UIView {
            while (true) {
                currentCell = currentCell.superview!
                if let cell = currentCell as? ProductTableCell {
                    if let product = cell.product {
                        if let stepper = sender as? UIStepper {
                            product.stockLevel = Int(stepper.value)
                        } else if
                            let textfield = sender as? UITextField,
                            let text = textfield.text {
                                if let newValue = Int(text) {
                                    product.stockLevel = newValue
                            }
                        }
                        
                        cell.stockStepper.value = Double(product.stockLevel)
                        cell.stockField.text = String(product.stockLevel)
                        productLogger.log(item: product)
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
            cell.product = product // p.49
            cell.nameLabel.text = product.name
            cell.descriptionLabel.text = product.productDescription
            cell.stockStepper.value = Double(product.stockLevel)
            cell.stockField.text = "\(product.stockLevel)"
        }
        
        return cell
    }
    
}
