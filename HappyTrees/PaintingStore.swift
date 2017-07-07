//
//  PaintingStore.swift
//  HappyTrees
//
//  Created by Anna Chan on 6/24/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import UIKit

class PaintingStore {
  var allPaintings = [Painting]()
  
  let paintingArchiveURL: URL = {
    let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentDirectory = documentsDirectories.first!
    return documentDirectory.appendingPathComponent("paintings.archive")
  }()
  
  init() {
    if let archivedPaintings = NSKeyedUnarchiver.unarchiveObject(withFile: paintingArchiveURL.path) as? [Painting] {
      allPaintings = archivedPaintings
    }
  }
  
  @discardableResult func createPainting(title: String) -> Painting {
    let newPainting = Painting(title: title)
    
    allPaintings.append(newPainting)
    return newPainting
  }
  
  @discardableResult func createPainting(title: String, dateCreated: Date, paintingKey: String) -> Painting {
    let newPainting = Painting(title: title, dateCreated: dateCreated, paintingKey: paintingKey)
    
    allPaintings.append(newPainting)
    return newPainting
  }
  
  func findPainting(byKey key: String) -> Painting? {
    var painting = allPaintings.filter { $0.paintingKey == key }
    if painting.isEmpty {
      return nil
    } else {
      return painting[0]
    }
  }
  
  func removePainting(_ painting: Painting) {
    if let index = allPaintings.index(of: painting) {
      allPaintings.remove(at: index)
    }
  }
  
  func movePainting(from fromIndex: Int, to toIndex: Int) {
    if fromIndex == toIndex {
      return
    }
    
    let movedPainting = allPaintings[fromIndex]
    allPaintings.remove(at: fromIndex)
    allPaintings.insert(movedPainting, at: toIndex)
  }
  
  func saveChanges() -> Bool {
    print("Saving paintings to: \(paintingArchiveURL.path)")
    return NSKeyedArchiver.archiveRootObject(allPaintings, toFile: paintingArchiveURL.path)
  }
  
  func getPaintingKeys() -> [String] {
    var allKeys = [String]()
    
    for painting in allPaintings {
      if let key = painting.paintingKey {
        allKeys.append(key)
      }
    }
    
    return allKeys
  }
  
  func getPaintingsSortedByDate() -> [Painting] {
    return allPaintings.sorted { $0.dateCreated < $1.dateCreated }
  }
  
}

