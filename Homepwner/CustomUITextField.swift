//
//  CustomUITextField.swift
//  Homepwner
//
//  Created by Michael Henry on 7/4/16.
//  Copyright © 2016 Digital Javelina, LLC. All rights reserved.
//

import UIKit

class CustomUITextField: UITextField {
    
    // in addition to below, need to change custom class for each textField in Storyboard to CustomUITextField
    
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        
        self.borderStyle = .RoundedRect
        
        return true
    }
    
    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        
        self.borderStyle = .None
        
        return true
    }
}
