//
//  AppDelegate.swift
//  HappyTrees
//
//  Created by Anna Chan on 6/21/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let supplyStore = SupplyStore()
    let favoriteStore = FavoriteStore()
    let paintingStore = PaintingStore()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Create stores
        let imageStore = ImageStore()
      
        sync_supplies_down()

        
        // Access trhe ItemsViewController and set its item store
        let tabController = window!.rootViewController as! UITabBarController
        
        
        let suppliesNavController = tabController.viewControllers?[0] as! UINavigationController
        let suppliesViewController =  suppliesNavController.topViewController as! SuppliesViewController
        suppliesViewController.supplyStore = supplyStore
        suppliesViewController.imageStore = imageStore
        
        let webNavController = tabController.viewControllers?[1] as! UINavigationController
        let tibHomeViewController = webNavController.topViewController as! TIBWebViewController
        tibHomeViewController.favoriteStore = favoriteStore

        
        let favoritesNavController = tabController.viewControllers?[2] as! UINavigationController
        let favoritesViewController = favoritesNavController.topViewController as! FavoritesViewController
        favoritesViewController.favoriteStore = favoriteStore
        
        let paintingNavController = tabController.viewControllers?[3] as! UINavigationController
        let paintingsViewController = paintingNavController.topViewController as! PaintingsViewController
        paintingsViewController.paintingStore = paintingStore
        paintingsViewController.imageStore = imageStore
        

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        print("ENTERING BACKGROUND")
        let supplySuccess = supplyStore.saveChanges()
        if (supplySuccess) {
            print("Saved all of the supplies")
        } else {
            print("Could not save any of the supplies")
        }
        let favoriteSuccess = favoriteStore.saveChanges()
        if (favoriteSuccess) {
            print("Saved all of the favorites")
        } else {
            print("Could not dave any of the favorites")
        }
        let paintingSuccess = paintingStore.saveChanges()
        if (paintingSuccess) {
            print("Saved all of the favorites")
        } else {
            print("Could not dave any of the favorites")
        }

    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        sync_supplies_down()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
  
    func sync_supplies_down() {
      fetchSupplies()
    }
  
    func fetchSupplies() {
      print("Fetching supplies")
      let supplies_url = URL(string: "https://happy-trees-web-production.herokuapp.com/api/supplies")
      let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
      }()
      
      let request = URLRequest(url: supplies_url!)
      let task = session.dataTask(with: request) {
        (data, response, error) -> Void in
        
        if let jsonData = data {
          do {
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
            print(jsonObject)
            self.findOrCreateSupplies(fromJSON: jsonObject as! [[String : Any]])
          } catch let error {
            print("Error creating json object: \(error)")
          }
        } else if let requestError = error {
          print("Error pulling supplies: \(requestError)")
        } else {
          print("Unexpected error with request")
        }
      }
      task.resume()
    }
  
    func findOrCreateSupplies(fromJSON json: [[String:Any]]) {
      for supplyData in json {
        let supply = supplyStore.findSupply(byKey: supplyData["supply_key"] as! String)
        if let foundSupply = supply {
          print("FOUND SUPPLY \(foundSupply)")
          foundSupply.name = supplyData["name"] as? String
          foundSupply.type = supplyData["type"] as? String
          foundSupply.amount = supplyData["amount"] as? Double
        } else {
          print("Creating supply")
          supplyStore.createSupply(name: supplyData["name"] as! String, type: supplyData["type"] as! String, amount: supplyData["amount"] as! Double, supplyKey: supplyData["supply_key"] as! String)
        }
      }
    }
  
  


}

