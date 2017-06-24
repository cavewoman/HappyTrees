//
//  FavoriteWebViewController.swift
//  HappyTrees
//
//  Created by Anna Chan on 6/23/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import UIKit
import WebKit

class FavoriteWevViewController: UIViewController {
    var webView: WKWebView!
    var favorite: Favorite! {
        didSet {
            navigationItem.title = getTitleName(title: favorite.title!)

        }
    }
    
    override func viewDidLoad() {
        webView = WKWebView()
        
        view = webView
        
        let myRequest = URLRequest(url: favorite.url!)
        webView.load(myRequest)
    }
    
    func getTitleName(title: String) -> String {
        let fullTitle = title.components(separatedBy: "-")
        
        let name = fullTitle[0]
        print("\(name)")
        return "\(name)"
    }
    
}
