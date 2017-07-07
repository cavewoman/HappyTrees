//
//  PaintingDatePickerViewController.swift
//  HappyTrees
//
//  Created by Anna Chan on 7/7/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import UIKit

class PaintingDatePickerViewController: UIViewController {
  @IBOutlet var datePicker: UIDatePicker!
  var painting: Painting!
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    datePicker.date = painting.dateCreated
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    painting.dateCreated = datePicker.date
  }
}
