//
//  MealTableViewController.swift
//  MyDiet
//
//  Created by Rafael Cunha on 14/03/17.
//  Copyright © 2017 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class MealTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var actualMenu: Menu = Menu(year: 0, month: 0, day: 0, calories: 0, id: "")
    var actualMeal: Meal = Meal(hour: 0, minute: 0, id: "")
    var getID: Meal = Meal(hour: 0, minute: 0, id: "")
    var allMeals: Array<Meal> = []
    var allMealsRealm: Array<MealRealm> = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var plusButton: UIBarButtonItem!
    
    var actualhour: Int = 0
    var actualminute: Int = 0
    var hour: Int = 0
    var minute: Int = 0
    var type: String = ""
    
    var isNew: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        if(isNew){
            
            self.plusButton.title = "Done"
            self.plusButton.action = #selector(MealItensTableViewController.Done)
        }
        else{
            self.plusButton.action = #selector(MealTableViewController.insert)
        }
        
        let getResults = self.getMeals()
        for result in getResults.enumerated() {
            if actualMenu.id == result.element.id{
                allMealsRealm.append(result.element)
                allMeals.append(self.changeMealsType(result: result.element))
            }
        }
        
        
        allMeals = allMeals.sorted(by: { $0.hour < $1.hour })
        
        let actualDate = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: actualDate)
        
        actualhour =  components.hour!
        actualminute = components.minute!
    }
    
    //------------------------------- Segue ----------------------------
    
    func insert(){
        performSegue(withIdentifier: "newMeal", sender: self)
    }
    
    func Done(){
        performSegue(withIdentifier: "backToMenus", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? NewMealViewController{
            destination.actualMenu = self.actualMenu
        }
        if let destination = segue.destination as? MenuTableViewController{
            destination.actualMenu = self.actualMenu
            destination.isNew = true
        }
        if let destination = segue.destination as? MealItensTableViewController{
            destination.actualMeal = self.actualMeal
            destination.actualMenu = self.actualMenu
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    //------------------------------- Table View ----------------------------


     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allMeals.count;
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MealTableViewCell = tableView.dequeueReusableCell(withIdentifier: "mealCell", for: indexPath) as! MealTableViewCell
        
        var displayTime: String
        
        if(0 <= self.allMeals[indexPath.row].minute && self.allMeals[indexPath.row].minute < 10){
            let tempMinute = "0" + String(self.allMeals[indexPath.row].minute)
            displayTime = String(self.allMeals[indexPath.row].hour) + ":" + tempMinute
        }
        else{
            displayTime = String(self.allMeals[indexPath.row].hour) + ":" + String(self.allMeals[indexPath.row].minute)
        }

        cell.timeField.text = displayTime
        cell.typeField.text = self.allMeals[indexPath.row].type
    
        return cell
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.actualMeal = allMeals[indexPath.row]
        self.performSegue(withIdentifier: "individualMeal", sender: indexPath.row)
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

 /*   func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
  */
    // Override to support editing the table view.
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
             self.allMealsRealm[indexPath.row].delete()
            self.allMealsRealm.remove(at: indexPath.row)
            let getItemResults = self.getItens()
            self.actualMeal = allMeals[indexPath.row]
            let itemID = actualMenu.id + "/" + String(actualMeal.hour) + String(actualMeal.minute) + actualMeal.type
            
            for result in getItemResults.enumerated() {
                if result.element.id == itemID{
                    result.element.delete()
                }
            }
            self.allMeals.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    //------------------------------- REALM ----------------------------

    
    func getMeals() -> Results<MealRealm> {
        do {
            let realm = try Realm()
            return realm.objects(MealRealm.self)
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    func getItens() -> Results<ItemRealm> {
        do {
            let realm = try Realm()
            return realm.objects(ItemRealm.self)
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    func changeMealsType(result: MealRealm) -> Meal{
        
        let changeMeal: Meal = Meal(hour: 0, minute: 0, id: "")
        
        changeMeal.hour = result.hour
        changeMeal.minute = result.minute
        changeMeal.type = result.type
        changeMeal.id = result.id
        
        return changeMeal
    }
 

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
