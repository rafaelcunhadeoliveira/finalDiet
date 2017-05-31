//
//  MeasureRealm.swift
//  MyDiet
//
//  Created by Rafael Cunha de Oliveira on 13/04/17.
//  Copyright © 2017 Rafael Cunha de Oliveira. All rights reserved.
//

import Foundation
import RealmSwift

class MeasureRealm: Object {
    
    dynamic var year: Int = 0
    dynamic var month: Int = 0
    dynamic var day: Int = 0
    dynamic var chest: Float = 0
    dynamic var waist: Float = 0
    dynamic var hips: Float = 0
    dynamic var leftArm: Float = 0
    dynamic var rightArm: Float = 0
    dynamic var leftThigh: Float = 0
    dynamic var rightThigh: Float = 0
    dynamic var weight: Float = 0
    
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
