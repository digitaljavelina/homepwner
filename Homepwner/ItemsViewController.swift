//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Michael Henry on 6/22/16.
//  Copyright © 2016 Digital Javelina, LLC. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    var itemStore: ItemStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get the height of the status bar and create an inset so that the table view does not overlap it
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        // set background image of table view
        let backgroundImageView = UIImageView(image: UIImage(named: "DigitalJavelina_logos_final_Page_2"))
        backgroundImageView.contentMode = .ScaleAspectFit
        tableView.backgroundView = backgroundImageView
        tableView.addSubview(backgroundImageView)
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // create extra row in table
        return itemStore.allItems.count + 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // get a new or recycled cell
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
        
        // set transparency of cell to see background view
        cell.backgroundColor = UIColor.clearColor()
        
        
        // add constant row
        if indexPath.row == itemStore.allItems.count {
            cell.textLabel?.text = "No more items!"
            cell.detailTextLabel?.text = ""
            tableView.rowHeight = 44.0
            cell.textLabel?.font.fontWithSize(16.0)
            cell.detailTextLabel?.font.fontWithSize(16.0)
        } else {
            let item = itemStore.allItems[indexPath.row]
            cell.textLabel?.text = item.name
            cell.detailTextLabel?.text = "$\(item.valueInDollars)"
            tableView.rowHeight = 60.0
            let textLabelFont = cell.textLabel?.font
            let detailTextLabelFont = cell.detailTextLabel?.font
            cell.textLabel?.font = textLabelFont?.fontWithSize(20.0)
            cell.detailTextLabel?.font = detailTextLabelFont?.fontWithSize(20.0)
        }
        
        return cell
    }

}