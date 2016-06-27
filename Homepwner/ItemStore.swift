//
//  ItemStore.swift
//  Homepwner
//
//  Created by Michael Henry on 6/22/16.
//  Copyright © 2016 Digital Javelina, LLC. All rights reserved.
//

import UIKit

class ItemStore {
    
    var allItems = [Item]()
    
    func createItem() -> Item {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
    }
    
    func removeItem(item: Item) {
        if let index = allItems.indexOf(item) {
            allItems.removeAtIndex(index)
        }
    }
    
    func moveItemAtIndex(fromIndex: Int, toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        // get reference to object being moved so that it can be reinserted
        let movedItem = allItems[fromIndex]
        
        // remove item from array
        allItems.removeAtIndex(fromIndex)
        
        // insert item in array at new location - only if not below "No more items!"
        if toIndex > allItems.count {
            allItems.insert(movedItem, atIndex: fromIndex)
        } else {
        
        allItems.insert(movedItem, atIndex: toIndex)
        }
    }
    
}
