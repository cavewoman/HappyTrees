//
//  FavoriteStore.swift
//  HappyTrees
//
//  Created by Anna Chan on 6/23/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import UIKit

class FavoriteStore {
  var allFavorites = [Favorite]()
  
  let favoriteArchiveURL: URL = {
    let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentDirectory = documentsDirectories.first!
    return documentDirectory.appendingPathComponent("favorites.archive")
  }()
  
  init() {
    if let archivedFavorites = NSKeyedUnarchiver.unarchiveObject(withFile: favoriteArchiveURL.path) as? [Favorite] {
      allFavorites = archivedFavorites
    }
  }
  
  @discardableResult func createFavorite(title: String, url: URL) -> Favorite {
    let newFavorite = Favorite(title: title, url: url)
    
    allFavorites.append(newFavorite)
    return newFavorite
  }
  
  @discardableResult func createFavorite(title: String, url: URL, requiredSupplyNames: [String]) -> Favorite {
    let newFavorite = Favorite(title: title, url: url, requiredSupplyNames: requiredSupplyNames)
    
    allFavorites.append(newFavorite)
    return newFavorite
  }
  
  @discardableResult func createFavorite(title: String, url: URL, favoriteKey: String, requiredSupplyNames: [String]) -> Favorite {
    let newFavorite = Favorite(title: title, url: url, favoriteKey: favoriteKey, requiredSupplyNames: requiredSupplyNames)
    
    allFavorites.append(newFavorite)
    return newFavorite
  }
  
  func findFavorite(byKey key: String) -> Favorite? {
    var favorite = allFavorites.filter { $0.favoriteKey == key }
    if favorite.isEmpty {
      return nil
    } else {
      return favorite[0]
    }
  }
  
  func removeFavorite(_ favorite: Favorite) {
    if let index = allFavorites.index(of: favorite) {
      allFavorites.remove(at: index)
    }
  }
  
  func moveFavorite(from fromIndex: Int, to toIndex: Int) {
    if fromIndex == toIndex {
      return
    }
    
    let movedFavorite = allFavorites[fromIndex]
    allFavorites.remove(at: fromIndex)
    allFavorites.insert(movedFavorite, at: toIndex)
  }
  
  func saveChanges() -> Bool {
    print("Saving favorites to: \(favoriteArchiveURL.path)")
    return NSKeyedArchiver.archiveRootObject(allFavorites, toFile: favoriteArchiveURL.path)
  }
  
}

