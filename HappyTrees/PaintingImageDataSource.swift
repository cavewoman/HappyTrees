//
//  PaintingImageDataSource.swift
//  HappyTrees
//
//  Created by Anna Chan on 6/24/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import UIKit

class PaintingImageDataSource: NSObject, UICollectionViewDataSource {
  var paintings = [Painting]()
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return paintings.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let identifier = "UIPaintingCollectionViewCell"
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! PaintingCollectionViewCell
    return cell
  }
}

