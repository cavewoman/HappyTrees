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
  
  @discardableResult func createSupply(name: String, type: String, amount: Double, supplyKey: String) -> Supply {
    let newSupply = Supply(name: name, type: type, amount: amount, supplyKey: supplyKey)
    
    allSupplies.append(newSupply)
    return newSupply
  }
  
  func findSupply(byKey key: String) -> Supply? {
    var supply = allSupplies.filter { $0.supplyKey == key }
    if supply.isEmpty {
      return nil
    } else {
      return supply[0]
    }
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
  
  func getAllSortedSupplies() -> [Supply] {
    return allSupplies.sorted { $0.name! < $1.name! }
  }
  
  func getSortedOilPaints() -> [Supply] {
    let oilPaints = allSupplies.filter { $0.type! == "Oil Paint" }
    return oilPaints.sorted { $0.name! < $1.name! }
  }
  
  func getSortedAcrylicPaints() -> [Supply] {
    let acrylicPaints = allSupplies.filter { $0.type! == "Acrylic Paint" }
    return acrylicPaints.sorted { $0.name! < $1.name! }
  }
  
  func getSortedBrushes() -> [Supply] {
    let brushes = allSupplies.filter { $0.type! == "Brush" }
    return brushes.sorted { $0.name! < $1.name! }
  }
  
  func getSortedCanvas() -> [Supply] {
    let canvas = allSupplies.filter { $0.type! == "Canvas"}
    return canvas.sorted { $0.name! < $1.name! }
  }
  
  func getSortedMediums() -> [Supply] {
    let mediums = allSupplies.filter { $0.type! == "Medium" }
    return mediums.sorted { $0.name! < $1.name! }
  }
  
}
