//
//  MealRealm.swift
//  MyDiet
//
//  Created by Rafael Cunha de Oliveira on 14/04/17.
//  Copyright © 2017 Rafael Cunha de Oliveira. All rights reserved.
//

import Foundation
import RealmSwift

class MealRealm: Object{
    dynamic var hour: Int = 0
    dynamic var minute: Int = 0
    dynamic var type: String = ""
//    var totalCalories: Float = 0
    dynamic var id: String = ""
    
    func save() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(self)
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    func delete() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(self)
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }

}
