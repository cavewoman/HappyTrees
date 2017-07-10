//
//  PaintingCollectionViewController.swift
//  HappyTrees
//
//  Created by Anna Chan on 7/7/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import UIKit

class PaintingsCollectionViewController: UIViewController, UICollectionViewDelegate {
  @IBOutlet var collectionView: UICollectionView!
  
  var paintingStore: PaintingStore!
  var imageStore: ImageStore!
  let paintingDataSource = PaintingImageDataSource()
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    paintingDataSource.paintings = paintingStore.getPaintingsSortedByDate()
    collectionView.dataSource = paintingDataSource
    collectionView.delegate = self
    collectionView.reloadData()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "showListView"?:
      let paintingsViewController = segue.destination as! PaintingsViewController
      paintingsViewController.imageStore = imageStore
      paintingsViewController.paintingStore = paintingStore
    case "showPaintingDetails"?:
      if let row = collectionView.indexPathsForSelectedItems?[0].row {
        let painting = paintingStore.getPaintingsSortedByDate()[row]
        let paintingDetailViewController = segue.destination as! PaintingDetailViewController
        paintingDetailViewController.painting = painting
        paintingDetailViewController.imageStore = imageStore
        paintingDetailViewController.paintingStore = paintingStore
      }
    case "addPainting"?:
      let painting = paintingStore.createPainting(title: "")
      let paintingDetailViewController = segue.destination as! PaintingDetailViewController
      paintingDetailViewController.painting = painting
      paintingDetailViewController.imageStore = imageStore
      paintingDetailViewController.paintingStore = paintingStore
    default:
      preconditionFailure("Unexpected segues identifier.")
    }
    
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      willDisplay cell: UICollectionViewCell,
                      forItemAt indexPath: IndexPath) {
    let painting = paintingDataSource.paintings[indexPath.row]
    
    let key = painting.paintingKey
    let imageToDisplay = imageStore.image(forKey: key!)
    
    let thumb = UIImage(data: UIImageJPEGRepresentation(imageToDisplay!, 0.8)!)
    
    let paintingCell = cell as! PaintingCollectionViewCell
    paintingCell.update(with: thumb)
    
  }
  
}
