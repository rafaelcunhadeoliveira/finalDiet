//
//  Meal.swift
//  MyDiet
//
//  Created by Rafael Cunha de Oliveira on 13/03/17.
//  Copyright © 2017 Rafael Cunha de Oliveira. All rights reserved.
//

import Foundation
class Meal: NSObject{
    
    var hour: Int
    var minute: Int
    var type: String
    var image: String
    var item: Array<(String, String, String)>
    var totalCalories: Float
    var id: String

//    
    init(hour: Int, minute: Int, id: String) {
        self.hour = hour
        self.minute = minute
        self.id = id
        self.type = ""
        self.image = ""
        self.item = []
        totalCalories = 0
    }
    
    func setType(type: String){
        self.type = type
    }
    
    func addItem(itenAdded: String, quantity: String, unity: String){
        item.append((itenAdded, quantity, unity))
    }
    
    func setTotalCalories(total: Float){
        self.totalCalories = total
    }

  

}
