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
    
    // designated initializer
    init() {
        for _ in 0..<5 {
            createItem()
        }
    }
    
    
}
