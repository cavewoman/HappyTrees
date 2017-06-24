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
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let paintingTitle = painting.title {
            titleField.text = paintingTitle
        }
       
        dateCreated.text = "\(painting.dateCreated)"
        
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        imageStore.setImage(image, forKey: painting.paintingKey!)
        imageView.image = image
        
        dismiss(animated: true, completion: nil)
    }
    
}