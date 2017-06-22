//
//  SupplyDetailViewController.swift
//  HappyTrees
//
//  Created by Anna Chan on 6/21/17.
//  Copyright © 2017 Anna Sherman. All rights reserved.
//

import Foundation


import UIKit

class SupplyDetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet var nameField: UITextField!
    @IBOutlet var typeField: UITextField!
    @IBOutlet var amountField: UITextField!

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
        let key = supply.supplyKey
        imageStore.deleteImage(forKey: key)
        imageView.image = nil
        removeImageButton.isHidden = true
    }
    
    var supply: Supply! {
        didSet {
            navigationItem.title = supply.name
        }
    }
    
    var supplyStore: SupplyStore!
    
    var imageStore: ImageStore!
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let supplyName = supply.name {
            nameField.text = supplyName
        }
        
        if let supplyType = supply.type {
            typeField.text = supplyType
        }
        
        if let supplyAmount = supply.amount {
            amountField.text = "\(supplyAmount)"
        }
        
        
        let key = supply.supplyKey
        let imageToDisplay = imageStore.image(forKey: key)
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
        if let enteredName = nameField.text, enteredName != "" {
            supply.name = nameField.text
            supply.type = typeField.text ?? ""
            supply.amount = Double(amountField.text!) ?? 0.0
        } else {
            supplyStore.removeSupply(supply)
        }
        
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        imageStore.setImage(image, forKey: supply.supplyKey)
        imageView.image = image
        
//        editorButtons.isHidden = false
        
        dismiss(animated: true, completion: nil)
    }
    
}
