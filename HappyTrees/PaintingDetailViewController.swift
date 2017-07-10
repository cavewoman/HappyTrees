//
//  PaintingDetailViewController.swift
//  HappyTrees
//
//  Created by Anna Chan on 6/24/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import UIKit

class PaintingDetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  @IBOutlet var titleField: UITextField!
  @IBOutlet var dateCreated: UILabel!
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var removeImageButton: UIButton!
  
  @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
    view.endEditing(true)
  }
  
  @IBAction func takePicture(_ sender: UIBarButtonItem) {
    let imagePicker = UIImagePickerController()
    
    imagePicker.sourceType = .photoLibrary
    
    imagePicker.delegate = self
    imagePicker.allowsEditing = false
    present(imagePicker, animated: true, completion: nil)
  }
  
  @IBAction func removePicture(_ sender: UIButton) {
    let key = painting.paintingKey
    imageStore.deleteImage(forKey: key!)
    imageView.image = nil
    removeImageButton.isHidden = true
  }
  
  var painting: Painting! {
    didSet {
      navigationItem.title = painting.title
    }
  }
  var paintingStore: PaintingStore!
  var imageStore: ImageStore!
  
  let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
  }()
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if let paintingTitle = painting.title {
      titleField.text = paintingTitle
    }
    
    dateCreated.text = dateFormatter.string(from: painting.dateCreated)
    
    let key = painting.paintingKey
    let imageToDisplay = imageStore.image(forKey: key!)
    if (imageToDisplay != nil) {
      removeImageButton.isHidden = false
    } else {
      removeImageButton.isHidden = true
    }
    imageView.image = imageToDisplay
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    view.endEditing(true)
    if let enteredTitle = titleField.text, enteredTitle != "" {
      painting.title = titleField.text
    } else {
      paintingStore.removePainting(painting)
    }
    
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "showDatePicker"?:
      let paintingDatePickerViewController = segue.destination as! PaintingDatePickerViewController
      paintingDatePickerViewController.painting = painting
    default:
      preconditionFailure("Unexpected segues identifier.")
    }
    
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
    if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
      imageStore.setImage(editedImage, forKey: painting.paintingKey!)
      imageView.image = editedImage
    } else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
      imageStore.setImage(originalImage, forKey: painting.paintingKey!)
      imageView.image = originalImage
    } else {
      imageView.image = nil
    }
    
    
    dismiss(animated: true, completion: nil)
  }
  
}
