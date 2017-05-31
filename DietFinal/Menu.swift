//
//  Menu.swift
//  MyDiet
//
//  Created by Rafael Cunha de Oliveira on 13/03/17.
//  Copyright © 2017 Rafael Cunha de Oliveira. All rights reserved.
//

import Foundation

class Menu: NSObject{
    var year: Int
    var month: Int
    var day: Int
    var meals: Array<Meal>
    var totalCalories: Float
    var id: String

    
    init(year: Int, month: Int, day: Int, calories: Float, id:String) {
        self.year = year
        self.month = month
        self.day = day
        self.id = id
        self.meals = []
        self.totalCalories = calories
    }
    
    func addMeal(newMeal: Meal){
        self.meals.append(newMeal)
    }
    
}
