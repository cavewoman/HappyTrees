//
//  SupplyStore.swift
//  HappyTrees
//
//  Created by Anna Chan on 6/21/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import UIKit

class SupplyStore {
    var allSupplies = [Supply]()
    
    let supplyArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("supplies.archive")
    }()
    
    init() {
        if let archivedSupplies = NSKeyedUnarchiver.unarchiveObject(withFile: supplyArchiveURL.path) as? [Supply] {
            allSupplies = archivedSupplies
        }
    }
    
    @discardableResult func createSupply(name: String, type: String, amount: Double) -> Supply {
        let newSupply = Supply(name: name, type: type, amount: amount)
        
        allSupplies.append(newSupply)
        return newSupply
    }
    
    func removeSupply(_ supply: Supply) {
        if let index = allSupplies.index(of: supply) {
            allSupplies.remove(at: index)
        }
    }
    
    func moveSupply(from fromIndex: Int, to toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        let movedSupply = allSupplies[fromIndex]
        allSupplies.remove(at: fromIndex)
        allSupplies.insert(movedSupply, at: toIndex)
    }
    
    func saveChanges() -> Bool {
        print("Saving supplies to: \(supplyArchiveURL.path)")
        return NSKeyedArchiver.archiveRootObject(allSupplies, toFile: supplyArchiveURL.path)
    }

}
