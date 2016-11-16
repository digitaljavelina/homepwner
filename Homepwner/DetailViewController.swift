//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Michael Henry on 6/27/16.
//  Copyright © 2016 Digital Javelina, LLC. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var serialNumberField: UITextField!
    @IBOutlet var valueField: UITextField!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var deletePhotoButton: UIBarButtonItem!
    
    var item: Item! {
        // change navbar title to item name
        didSet {
            navigationItem.title = item.name
        }
    }
    
    var imageStore: ImageStore!
    
    let numberFormatter: NSNumberFormatter = {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .DecimalStyle
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFomatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .NoStyle
        return formatter
    }()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.text = item.name
        serialNumberField.text = item.serialNumber
        
        // use number and date formatters here instead of string interpolation
        valueField.text = numberFormatter.stringFromNumber(item.valueInDollars)
        dateLabel.text = dateFomatter.stringFromDate(item.dateCreated)
        
        // get item key
        let key = item.itemKey
        
        // if there is an associated image with the item, display it on the image view
        let imageToDisplay = imageStore.imageForKey(key)
        imageView.image = imageToDisplay
        
        // enable delete photo button
        if imageView.image != nil {
            deletePhotoButton.enabled = true
        } else {
            deletePhotoButton.enabled = false
        }
    }
    
    // call this method when the DetailViewController is about to pop off the stack and transition back to ItemsViewController
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        // save changes to item if editing is performed
        item.name = nameField.text ?? ""
        item.serialNumber = serialNumberField.text
        
        if let valueText = valueField.text, let value = numberFormatter.numberFromString(valueText) {
            item.valueInDollars = value.integerValue
        } else {
            item.valueInDollars = 0
        }
        
        // clear firstResponder when user taps the Back button
        view.endEditing(true)
    }
    
    // keyboard is dismissed when user presses the return key (UITextFieldDelegate method)
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // keyboard is dismissed when background is tapped
    @IBAction func backgroundTapped(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func takePicture(sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        
        // create crosshair overlay
        let crosshairImage = UIImage(named: "crosshair.png")
        let crosshairImageView = UIImageView(image: crosshairImage)
        crosshairImageView.frame = CGRectMake(0, 0, 100, 100)
        crosshairImageView.center = imagePicker.view.center

        
        // if the device has a camera, take a picture - otherwise, just pick from photo library
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            imagePicker.sourceType = .Camera
            imagePicker.cameraOverlayView = crosshairImageView
            
        } else {
            imagePicker.sourceType = .PhotoLibrary
        }
        
        // set the delegate to self
        imagePicker.delegate = self
        
        // allow editing of the image
        imagePicker.allowsEditing = true
        
        // place the image picker on the screen
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    //MARK: - Delegate method
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        // get picked image from info dictionary
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // store the image in the ImageStore for the item's key
        imageStore.setImage(image, forKey: item.itemKey)
        
        // put that image on the screen in the imageView
        imageView.image = image
        
        // dismiss image picker - this method MUST be implemented
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func deletePhoto(sender: UIBarButtonItem) {
        imageStore.deleteImageForKey(item.itemKey)
        imageView.image = nil
        deletePhotoButton.enabled = false
    }
    
}
