//
//  SuppliesViewController.swift
//  HappyTrees
//
//  Created by Anna Chan on 6/21/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import UIKit

class SuppliesViewController: UITableViewController {
    var supplyStore: SupplyStore!
    var imageStore: ImageStore!
    
    enum SupplyAmount {
        case moreThanHalfFull
        case halfFull
        case lessThanHalfFull
        case empty
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return supplyStore.allSupplies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SupplyCell", for: indexPath)
        
        
        let supply = supplyStore.allSupplies[indexPath.row]
        
        cell.textLabel?.text = supply.name
        switch getAmountType(amount: supply.amount) {
        case .moreThanHalfFull:
            cell.backgroundColor = .green
        case .halfFull:
            cell.backgroundColor = .yellow
        case .lessThanHalfFull:
            cell.backgroundColor = .orange
        default:
            cell.backgroundColor = .red
            
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showSupply"?:
            let supply = supplyStore.createSupply(name: "", type: "", amount: 0.0)
            let supplyDetailViewController = segue.destination as! SupplyDetailViewController
            supplyDetailViewController.supply = supply
            supplyDetailViewController.imageStore = imageStore
        case "updateSupplyDetails"?:
            if let row = tableView.indexPathForSelectedRow?.row {
                let supply = supplyStore.allSupplies[row]
                let supplyDetailViewController = segue.destination as! SupplyDetailViewController
                supplyDetailViewController.supply = supply
                supplyDetailViewController.imageStore = imageStore
            }
        default:
            preconditionFailure("Unexpected segues identifier.")
        }
        
    }
    
    
    func getAmountType(amount: Double?) -> SupplyAmount {
        if let amount = amount {
            if amount > 0.5 {
                return .moreThanHalfFull
            } else if amount == 0.5 {
                return .halfFull
            } else if (amount > 0) && (amount < 0.5) {
                return .lessThanHalfFull
            } else {
                return .empty
            }
        } else {
            return .empty
        }
    }
}
