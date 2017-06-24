//
//  PaintingsViewController.swift
//  HappyTrees
//
//  Created by Anna Chan on 6/24/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import UIKit

class PaintingsViewController: UITableViewController {

    
    var paintingStore: PaintingStore!
    var imageStore: ImageStore!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paintingStore.allPaintings.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaintingCell", for: indexPath)
        
        let painting = paintingStore.allPaintings[indexPath.row]
        
        cell.textLabel?.text = painting.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let painting = paintingStore.allPaintings[indexPath.row]
            paintingStore.removePainting(painting)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "addPainting"?:
            let painting = paintingStore.createPainting(title: "")
            let paintingDetailViewController = segue.destination as! PaintingDetailViewController
            paintingDetailViewController.painting = painting
            paintingDetailViewController.imageStore = imageStore
            paintingDetailViewController.paintingStore = paintingStore
        case "updatePainting"?:
            if let row = tableView.indexPathForSelectedRow?.row {
                let painting = paintingStore.allPaintings[row]
                let paintingDetailViewController = segue.destination as! PaintingDetailViewController
                paintingDetailViewController.painting = painting
                paintingDetailViewController.imageStore = imageStore
                paintingDetailViewController.paintingStore = paintingStore
            }
        default:
            preconditionFailure("Unexpected segues identifier.")
        }
        
    }
}
