//
//  Painting.swift
//  HappyTrees
//
//  Created by Anna Chan on 6/24/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import UIKit

class Painting: NSObject, NSCoding {
  var title: String?
  var dateCreated: Date
  let paintingKey: String?
  
  init(title: String) {
    self.title = title
    self.dateCreated = Date()
    self.paintingKey = UUID().uuidString
    
    super.init()
  }
  
  init(title: String, dateCreated: Date, paintingKey: String) {
    self.title = title
    self.dateCreated = dateCreated
    self.paintingKey = paintingKey
    
    super.init()
  }
  
  convenience override init() {
    self.init(title: "")
  }
  
  required init(coder aDecoder: NSCoder) {
    title = aDecoder.decodeObject(forKey: "title") as! String?
    dateCreated = aDecoder.decodeObject(forKey: "dateCreated") as! Date
    paintingKey = aDecoder.decodeObject(forKey: "paintingKey") as! String?
    
    super.init()
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(title, forKey: "title")
    aCoder.encode(dateCreated, forKey: "dateCreated")
    aCoder.encode(paintingKey, forKey: "paintingKey")
  }
  
}
