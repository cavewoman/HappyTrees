//
//  PaintingImageDataSource.swift
//  HappyTrees
//
//  Created by Anna Chan on 6/24/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import UIKit

class PaintingImageDataSource: NSObject, UICollectionViewDataSource {
    var images = [UIImage]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "PaintingImageCollectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! PaintingCollectionViewCell
        return cell
    }
}

