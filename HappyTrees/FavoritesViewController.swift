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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

}
