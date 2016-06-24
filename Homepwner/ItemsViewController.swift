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
    var sections = [Section]()
    var expensiveSection = Section(name: "Expensive", items: [Item]())
    var cheapSection = Section(name: "Cheap", items: [Item]())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get the height of the status bar and create an inset so that the table view does not overlap it
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        for item in itemStore.allItems {
            if item.valueInDollars <= 50 {
                cheapSection.items.append(item)
            } else {
                expensiveSection.items.append(item)
            }
        }
        
        sections.append(expensiveSection)
        sections.append(cheapSection)
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    // make 2 sections
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // get a new or recycled cell
        let cell = tableView.dequeueReusableCellWithIdentifier("UITableViewCell", forIndexPath: indexPath)
        
        // set the text on the cell with the description of the item that is at the nth index of items, where n = row this cell will appear in on the tableView
        let item = sections[indexPath.section].items[indexPath.row]
        
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].name
    }
    

}