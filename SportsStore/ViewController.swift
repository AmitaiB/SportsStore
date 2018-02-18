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
        let bridge = EventBridge(callback: updateStockLevel)
        productStore.callback = bridge.inputCallback
    }
    
    func updateStockLevel(name: String, level: Int) {
        for cell in tableView.visibleCells {
            if
                let pcell = cell as? ProductTableCell,
                pcell.product?.name == name
            {
                pcell.stockStepper.value = Double(level)
                pcell.stockField.text = String(level)
            }
        }
        displayTotalStock()
    }
    
    func displayTotalStock(in currency: StockTotalFactory.Currency = .usd) {
        let finalTotals: (Int, Double) = productStore.products.reduce((0, 0.0)) { (totals, product) in
            return (
                totals.0 + product.stockLevel,
                totals.1 + product.stockValue
            )
        }

        let factory = StockTotalFactory.getFactory(for: currency)
        let totalAmount = factory.converter?.convert(total: finalTotals.1)
        let formatted = factory.formatter?.format(total: totalAmount ?? -1)
        
        totalStockLabel.text = """
        Total of \(finalTotals.0) Products in Stock
        Total Value: \(formatted ?? "Error, no value")
        """
    }
    
    @IBAction func currencyChanged(_ sender: UISegmentedControl) {
        if let selectedCurrency = StockTotalFactory.Currency(rawValue: sender.selectedSegmentIndex)
        {
            displayTotalStock(in: selectedCurrency)
        }
    }
    
    // p.47
    @IBAction func stockLevelDidChange(_ sender: Any) {
        // grab a reference to the cell and its product
        guard
            let productCell = productCellFor(sender : sender),
            let product     = productCell.product
            else { return }
        
        
        // 𝚫Stepper? Update product and textfield
        if let stepper = sender as? UIStepper {
            let newValue = Int(stepper.value)
            product.stockLevel = newValue
            productCell.stockField.text = String(newValue)
        }
        
        // 𝚫TextField? Update product and stepper
        if
            let textfield = sender as? UITextField,
            let text = textfield.text,
            let newValue = Int(text)
        {
            product.stockLevel = newValue
            productCell.stockStepper.value = Double(newValue)
        }
        
        productLogger.log(item: product)
        displayTotalStock()
        
    }
  
    /// Climb the view heirarchy to grab a reference to the ProductTableCell
    fileprivate func productCellFor(sender: Any) -> ProductTableCell? {
        var currentView = sender as? UIView
        
        while currentView != nil {
            if let productCell = currentView as? ProductTableCell {
                return productCell
            }
            else {
                currentView = currentView?.superview
            }
        }
        return nil
    }
    
    
    // MARK: UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productStore.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = productStore.products[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
        
        if let productCell = cell as? ProductTableCell {
            productCell.product               = product // p.49
            productCell.nameLabel.text        = product.name
            productCell.descriptionLabel.text = product.productDescription
            productCell.stockStepper.value    = Double(product.stockLevel)
            productCell.stockField.text       = "\(product.stockLevel)"
        }
        
        return cell
    }
    
}
