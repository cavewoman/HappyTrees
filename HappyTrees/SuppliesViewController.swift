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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        navigationItem.leftBarButtonItem = editButtonItem
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
        cell.detailTextLabel?.text = "\(supply.amount!)"
        switch getAmountType(amount: supply.amount) {
        case .moreThanHalfFull:
            cell.backgroundColor = UIColor().colorFromHex(hexValue: "6a8347")
        case .halfFull:
            cell.backgroundColor = UIColor().colorFromHex(hexValue: "71b238")
        case .lessThanHalfFull:
            cell.backgroundColor = UIColor().colorFromHex(hexValue: "a6cb45")
        default:
            cell.backgroundColor = UIColor().colorFromHex(hexValue: "fefcd7")
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let supply = supplyStore.allSupplies[indexPath.row]
            supplyStore.removeSupply(supply)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showSupply"?:
            let supply = supplyStore.createSupply(name: "", type: "", amount: 0.0)
            let supplyDetailViewController = segue.destination as! SupplyDetailViewController
            supplyDetailViewController.supply = supply
            supplyDetailViewController.imageStore = imageStore
            supplyDetailViewController.supplyStore = supplyStore
        case "updateSupplyDetails"?:
            if let row = tableView.indexPathForSelectedRow?.row {
                let supply = supplyStore.allSupplies[row]
                let supplyDetailViewController = segue.destination as! SupplyDetailViewController
                supplyDetailViewController.supply = supply
                supplyDetailViewController.imageStore = imageStore
                supplyDetailViewController.supplyStore = supplyStore
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

extension UIColor {
    func colorFromHex(hexValue: String) -> UIColor {
        let (redText, greenText, blueText) = parseHexString(hexValue: hexValue)
        
        let redFloat = Float(redText)
        let greenFloat = Float(greenText)
        let blueFloat = Float(blueText)
        
        let red: Float = redFloat! / 0xff
        let green: Float = greenFloat! / 0xff
        let blue: Float = blueFloat! / 0xff
        
        return UIColor(colorLiteralRed: red, green: green, blue: blue, alpha: 1)
    }
    
    func parseHexString(hexValue: String) -> (String, String, String) {
        var redText: String = "0x"
        var greenText: String = "0x"
        var blueText: String = "0x"

        for (index, char) in hexValue.characters.enumerated() {
            switch index {
            case 0, 1:
                redText += "\(char)"
            case 2, 3:
                greenText += "\(char)"
            default:
                blueText += "\(char)"
            }
        }
        return (redText, greenText, blueText)
    }
}
