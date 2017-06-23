//
//  TIBHomeWebViewController.swift
//  HappyTrees
//
//  Created by Anna Chan on 6/21/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import Foundation
import WebKit

class TIBWebViewController: UIViewController {
    var webView: WKWebView!
    @IBAction func artButtonClicked(_ sender: UIBarButtonItem) {
        let url = webView.url
        print("\(url)")
        print("\(webView.title)")
    }
    
    override func viewDidLoad() {
        webView = WKWebView()
        
        view = webView
        
        let myURL = URL(string: "http://www.twoinchbrush.com/")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
    }
}
