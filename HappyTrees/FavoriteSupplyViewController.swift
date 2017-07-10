//
//  FavoriteSupplyView.swift
//  HappyTrees
//
//  Created by Anna Chan on 7/10/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import UIKit

class FavoriteSupplyViewController: UITableViewController {
  var favorite: Favorite! {
    didSet {
      navigationItem.title = getTitleName(title: favorite.title!)
    }
  }
  var favoriteStore: FavoriteStore!
  var supplyStore: SupplyStore!
  @IBOutlet weak var webView: UIWebView!

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }
 
  override func viewDidLoad() {
    let myRequest = URLRequest(url: getImageUrl(from: favorite.url!))
    webView.loadRequest(myRequest)
  }
  
  func getImageUrl(from url: URL) -> URL {
    let splitURL = url.relativePath.components(separatedBy: "/")
    let imageId = splitURL[2]
    
    let url = "http://www.twoinchbrush.com/images/painting\(imageId).png"
    
    return URL(string: url)!
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return (favorite.requiredSupplyNames?.count)!
    case 1:
      let needSupplyCount = supplyStore.getSuppliesNeeded(supplyNames: favorite.requiredSupplyNames!).count
      return needSupplyCount > 0 ? needSupplyCount : 1
    default:
      return 1
    }
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch section {
    case 0:
      return "Required Paints"
    case 1:
      return "What you need"
    default:
      return "This section should not be here"
    }
  }
  
  public override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 61.0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteSupplyCell", for: indexPath)
    
    switch indexPath.section {
    case 0:
      let supplyName = favorite.requiredSupplyNames![indexPath.row]
      cell.textLabel?.text = supplyName
    case 1:
      let suppliesNeeded = supplyStore.getSuppliesNeeded(supplyNames: favorite.requiredSupplyNames!)
      if suppliesNeeded.count > 0 {
        cell.textLabel?.text = suppliesNeeded[indexPath.row].name
      } else {
        cell.textLabel?.text = "You have all the supplies you need!"
      }
      
    default:
      cell.textLabel?.text = "I should not be here"
    }
    
    return cell
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "showFavoriteWebView"?:
      let favoriteWebViewController = segue.destination as! FavoriteWebViewController
      favoriteWebViewController.favorite = favorite
    default:
      preconditionFailure("Unexpected segues identifier.")
    }
  }
  
  func getTitleName(title: String) -> String {
    let fullTitle = title.components(separatedBy: "-")
    
    let name = fullTitle[0]
    return "\(name)"
  }
  
  
  
}
