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
    var url: String?
    var favoriteKey: String?
    
    init(title: String, url: String) {
        self.title = title
        self.url = url
        self.favoriteKey = UUID().uuidString
        
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObject(forKey: "title") as! String?
        url = aDecoder.decodeObject(forKey: "url") as! String?
        favoriteKey = aDecoder.decodeObject(forKey: "favoriteKey") as! String?
        
        
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(url, forKey: "url")
        aCoder.encode(favoriteKey, forKey: "favoriteKey")
    }
    
}
