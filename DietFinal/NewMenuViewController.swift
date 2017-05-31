//
//  NewMenuViewController.swift
//  MyDiet
//
//  Created by Rafael Cunha on 14/03/17.
//  Copyright © 2017 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit
import CoreData

class NewMenuViewController: UIViewController {
    
    var year: Int = 0
    var month: Int = 0
    var day: Int = 0
    var id: String = ""
    var calories: Float = 0
    
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var caloriesField: UITextField!
    
    var actualMenu: Menu = Menu(year: 0, month: 0, day: 0, calories: 0, id: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timePicker.datePickerMode = UIDatePickerMode.date
        timePicker.addTarget(self, action: #selector(dateTarget), for: UIControlEvents.valueChanged)
        let actualDate = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: actualDate)
        
        year =  components.year!
        month = components.month!
        day = components.day!
        self.hideKeyboard()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //---------------------------Actions------------------------------

    
    @IBAction func dateTarget (sender: UIDatePicker){
        let date = sender.date
        let calendar = Calendar.current
        
        year = calendar.component(.year, from: date)
        month = calendar.component(.month, from: date)
        day = calendar.component(.day, from: date)
    }
    
    
    @IBAction func nextButton(_ sender: Any) {
        let menuID = String(self.year) + String(self.month) + String(self.day)
        self.saveRealmMenu(id: menuID)
        self.setNewMenu(id: menuID)
        
                self.performSegue(withIdentifier: "mealsInMenu", sender: sender)
            
        }
        
    
    //---------------------------Segue------------------------------

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MealTableViewController{
            destination.actualMenu = self.actualMenu
        }
    }
    //---------------------------Logic------------------------------
    func saveRealmMenu(id: String){
        let newMenuRealm = MenuRealm()
        
        newMenuRealm.day = self.day
        newMenuRealm.month = self.month
        newMenuRealm.year = self.year
        newMenuRealm.totalCalories = self.calories
        newMenuRealm.id = id
        
        newMenuRealm.save()

    }
    func setNewMenu(id: String){
        
        self.actualMenu.day = self.day
        self.actualMenu.month = self.month
        self.actualMenu.year = self.year
        self.actualMenu.totalCalories = self.calories
        self.actualMenu.id = id
        
    }
    
    func deleteAll(){
        
    }
    
    
}

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    

