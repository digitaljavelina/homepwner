//
//  DatePickerViewController.swift
//  Homepwner
//
//  Created by Michael Henry on 7/31/16.
//  Copyright © 2016 Digital Javelina, LLC. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    var item: Item!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        datePicker.date = item.dateCreated
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        item.dateCreated = datePicker.date
    }
   

}
