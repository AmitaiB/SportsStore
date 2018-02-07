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
    @IBOutlet weak var totalStockLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var productStore = ProductDataStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayTotalStock()
        
        productStore.callback = { (aProduct: Product) in
            for cell in self.tableView.visibleCells {
                if
                    let pcell = cell as? ProductTableCell,
                    pcell.product?.name == aProduct.name
                {
                    pcell.stockStepper.value = Double(aProduct.stockValue)
                    pcell.stockField.text = String(aProduct.stockLevel)
                }
            }
            self.displayTotalStock()
        }
    }

    func displayTotalStock() {
        let finalTotals: (Int, Double) = productStore.products.reduce((0, 0.0)) { (totals, product) in
            return (
                totals.0 + product.stockLevel,
                totals.1 + product.stockValue
            )
        }
        
        let factory = StockTotalFactory.getFactory(for: .gbp)
        let totalAmount = factory.converter?.convert(total: finalTotals.1)
        let formatted = factory.formatter?.format(total: totalAmount ?? -1)
        
        totalStockLabel.text = """
        Total of \(finalTotals.0) Products in Stock
        Total Value: \(formatted ?? "Error, no value")
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
        return productStore.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = productStore.products[indexPath.row]
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
