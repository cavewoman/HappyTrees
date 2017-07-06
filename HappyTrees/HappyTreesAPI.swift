//
//  HappyTreesAPI.swift
//  HappyTrees
//
//  Created by Anna Chan on 7/6/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import Foundation

class HappyTreesAPI {
  
  func sync_supplies_down(supplyStore: SupplyStore) {
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
          self.findOrCreateSupplies(fromJSON: jsonObject as! [[String : Any]], supplyStore: supplyStore)
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
  
  func findOrCreateSupplies(fromJSON json: [[String:Any]], supplyStore: SupplyStore) {
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
  
  func sync_supplies_up(supplyStore: SupplyStore) {
    print("Posting supplies to server")
    
    var body = ["supplies": []]
    for supply in supplyStore.allSupplies {
      let formatted = formatSupplyForPost(supply: supply)
      body["supplies"]?.append(formatted)
    }
    
    let session: URLSession = {
      let config = URLSessionConfiguration.default
      return URLSession(configuration: config)
    }()
    
    let jsonData = try? JSONSerialization.data(withJSONObject: body)
    let supplies_url = URL(string: "https://happy-trees-web-production.herokuapp.com/api/sync_supplies")
    
    var request = URLRequest(url: supplies_url!)
    request.httpMethod = "POST"
    request.httpBody = jsonData
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let task = session.dataTask(with: request) {
      (data, response, error) -> Void in
      
      if let jsonData = data {
        do {
          let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
          print("RETURN FROM POST")
          print(jsonObject)
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
  
  func formatSupplyForPost(supply: Supply) -> [String:Any] {
    return ["name": supply.name!, "type": supply.type!, "amount": supply.amount!, "supply_key": supply.supplyKey!]
  }

}
