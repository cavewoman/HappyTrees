//
//  Favorite.swift
//  HappyTrees
//
//  Created by Anna Chan on 6/23/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import UIKit

class Favorite: NSObject, NSCoding {
  var title: String?
  var url: URL?
  var favoriteKey: String?
  var requiredSupplyNames: [String]?
  
  init(title: String, url: URL) {
    self.title = title
    self.url = url
    self.favoriteKey = UUID().uuidString
    self.requiredSupplyNames = []
    
    super.init()
  }
  
  init(title: String, url: URL, requiredSupplyNames: [String]) {
    self.title = title
    self.url = url
    self.favoriteKey = UUID().uuidString
    self.requiredSupplyNames = requiredSupplyNames
    
    super.init()
  }
  
  init(title: String, url: URL, favoriteKey: String, requiredSupplyNames: [String]) {
    self.title = title
    self.url = url
    self.favoriteKey = favoriteKey
    self.requiredSupplyNames = requiredSupplyNames
    
    super.init()
  }
  
  required init(coder aDecoder: NSCoder) {
    title = aDecoder.decodeObject(forKey: "title") as! String?
    url = aDecoder.decodeObject(forKey: "url") as! URL?
    favoriteKey = aDecoder.decodeObject(forKey: "favoriteKey") as! String?
    requiredSupplyNames = aDecoder.decodeObject(forKey: "requiredSupplyNames") as? [String]
    
    
    super.init()
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(title, forKey: "title")
    aCoder.encode(url, forKey: "url")
    aCoder.encode(favoriteKey, forKey: "favoriteKey")
    aCoder.encode(requiredSupplyNames, forKey: "requiredSupplyNames")
  }
  
}
