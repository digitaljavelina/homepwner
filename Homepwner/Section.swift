//
//  Section.swift
//  Homepwner
//
//  Created by Michael Henry on 6/23/16.
//  Copyright © 2016 Digital Javelina, LLC. All rights reserved.
//

import UIKit

class Section {
    
    var name: String
    var items: [Item]
    
    init(name: String, items: [Item]) {
        self.name = name
        self.items = items
    }
    
}
