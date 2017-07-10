//
//  PaintingImage.swift
//  HappyTrees
//
//  Created by Anna Chan on 6/24/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import Foundation

class PaintingImage {
  let title: String
  let imageId: String
  
  init(title: String, imageId: String, originalImageOrientation: String) {
    self.title = title
    self.imageId = imageId
  }
  
}

extension PaintingImage: Equatable {
  static func == (lhs: PaintingImage, rhs: PaintingImage) -> Bool {
    return lhs.imageId == rhs.imageId
  }
}
