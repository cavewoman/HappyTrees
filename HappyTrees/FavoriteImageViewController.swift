//
//  FavoriteImageViewController.swift
//  HappyTrees
//
//  Created by Anna Chan on 6/25/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import UIKit
import WebKit

class FavoriteImageViewController: UIViewController {
    var webView: WKWebView!
    var favorite: Favorite! {
        didSet {
            navigationItem.title = getTitleName(title: favorite.title!)
            
        }
    }
    
    override func viewDidLoad() {
        webView = WKWebView()
        
        view = webView
        
        let myRequest = URLRequest(url: getImageUrl(from: favorite.url!))
        webView.load(myRequest)
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
        print("\(name)")
        return "\(name)"
    }
    
    func getImageUrl(from url: URL) -> URL {
        let splitURL = url.relativePath.components(separatedBy: "/")
        let imageId = splitURL[2]
        
        let url = "http://www.twoinchbrush.com/images/painting\(imageId).png"
        
        return URL(string: url)!
    }
    
}
