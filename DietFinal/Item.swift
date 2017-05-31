//
//  Item.swift
//  MyDiet
//
//  Created by Rafael Cunha de Oliveira on 14/04/17.
//  Copyright © 2017 Rafael Cunha de Oliveira. All rights reserved.
//

import Foundation
class Item: NSObject{

    var name: String
    var quantity: String
    var unity: String
    var id: String
    
    init(name: String, quantity: String, unity: String, id: String) {
        self.name = name
        self.quantity = quantity
        self.unity = unity
        self.id = id
    }
}
