//
//  Supply.swift
//  HappyTrees
//
//  Created by Anna Chan on 6/21/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import UIKit

class Supply: NSObject, NSCoding {
  var name: String?
  var type: String?
  var amount: Double? = 0.0
  let supplyKey: String?
  
  init(name: String, type: String, amount: Double) {
    self.name = name
    self.type = type
    self.amount = amount
    self.supplyKey = UUID().uuidString
    
    super.init()
  }
  
  init(name: String, type: String, amount: Double, supplyKey: String) {
    self.name = name
    self.type = type
    self.amount = amount
    self.supplyKey = supplyKey
    
    super.init()
  }
  
  convenience override init() {
    self.init(name: "", type: "", amount: 0.0)
  }
  
  required init(coder aDecoder: NSCoder) {
    name = aDecoder.decodeObject(forKey: "name") as! String?
    type = aDecoder.decodeObject(forKey: "type") as! String?
    amount = aDecoder.decodeObject(forKey: "amount") as! Double?
    supplyKey = aDecoder.decodeObject(forKey: "supplyKey") as! String?
    
    
    super.init()
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: "name")
    aCoder.encode(type, forKey: "type")
    aCoder.encode(amount, forKey: "amount")
    aCoder.encode(supplyKey, forKey: "supplyKey")
  }
  
}
