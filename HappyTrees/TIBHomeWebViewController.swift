//
//  TIBHomeWebViewController.swift
//  HappyTrees
//
//  Created by Anna Chan on 6/21/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import Foundation
import WebKit

class TIBWebViewController: UIViewController, WKNavigationDelegate {
  var webView: WKWebView!
  var favoriteStore: FavoriteStore!
  
  @IBAction func artButtonClicked(_ sender: UIBarButtonItem) {
    let js = "var lis = document.body.querySelectorAll(\"a[href='/tools#colors'] li\"); " +
              "var suppliesString='';" +
              "for(var i=0; i<lis.length; i++){" +
                "var e = lis[i].innerHTML;" +
                "suppliesString += e + '?';" +
              "}" +
            "suppliesString"
    webView.evaluateJavaScript(js) { (result, error) in
      if error == nil {
        if let result = result{
          let supply_names = (result as AnyObject).components(separatedBy: "?").filter { $0 != "" }
          self.favoriteStore.createFavorite(title: self.webView.title!, url: self.webView.url!, requiredSupplyNames: supply_names)
          print(supply_names)
        }
      } else {
        print("ERROR EVALUATING JS")
        print(error ?? "")
        self.favoriteStore.createFavorite(title: self.webView.title!, url: self.webView.url!)
      }
    }
    
  }
  
  @IBAction func navigateBackInWebButtonClicked(_ sender: UIBarButtonItem) {
    webView.goBack()
  }
  override func viewDidLoad() {
    webView = WKWebView()
    
    view = webView
    
    let myURL = URL(string: "http://www.twoinchbrush.com/all-paintings")
    let myRequest = URLRequest(url: myURL!)
    webView.load(myRequest)
    
  }
}
