//
//  FavoritesViewController.swift
//  HappyTrees
//
//  Created by Anna Chan on 6/23/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import UIKit

class FavoritesViewController: UITableViewController {
  var favoriteStore: FavoriteStore!
  var supplyStore: SupplyStore!
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    navigationItem.leftBarButtonItem = editButtonItem
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return favoriteStore.allFavorites.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath)
    
    let favorite = favoriteStore.allFavorites[indexPath.row]
    
    cell.textLabel?.text = getTitleName(title: favorite.title!)
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let favorite = favoriteStore.allFavorites[indexPath.row]
      favoriteStore.removeFavorite(favorite)
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "showFavoriteImageView"?:
      if let row = tableView.indexPathForSelectedRow?.row {
        let favorite = favoriteStore.allFavorites[row]
        let favoriteImageViewController = segue.destination as! FavoriteImageViewController
        favoriteImageViewController.favorite = favorite
      }
    case "showFavoriteDetails"?:
      if let row = tableView.indexPathForSelectedRow?.row {
        let favorite = favoriteStore.allFavorites[row]
        let favoriteSupplyViewController = segue.destination as! FavoriteSupplyViewController
        favoriteSupplyViewController.favorite = favorite
        favoriteSupplyViewController.favoriteStore = favoriteStore
        favoriteSupplyViewController.supplyStore = supplyStore
      }
    default:
      preconditionFailure("Unexpected segues identifier.")
    }
    
  }
  
  func getTitleName(title: String) -> String {
    let fullTitle = title.components(separatedBy: "-")
    
    let name = fullTitle[0]
    print("\(name)")
    return "\(name)"
  }
  
  
}
