//
//  PaintingCollectionViewCell.swift
//  HappyTrees
//
//  Created by Anna Chan on 6/24/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import UIKit

class PaintingCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func update(with image: UIImage?) {
        if let imageToDisplay = image {
            imageView.image = imageToDisplay
        }
    }
}

