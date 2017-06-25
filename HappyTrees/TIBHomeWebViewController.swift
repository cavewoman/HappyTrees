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
        favoriteStore.createFavorite(title: webView.title!, url: webView.url!)
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
