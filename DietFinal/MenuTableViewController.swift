//
//  MenuTableViewController.swift
//  MyDiet
//
//  Created by Rafael Cunha on 14/03/17.
//  Copyright © 2017 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class MenuTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var allMenus: Array<Menu> = []
    var allMenusRealm: Array<MenuRealm> = []
    var actualMenu: Menu = Menu(year: 0, month: 0, day: 0, calories: 0, id: "")
    var isDone: Bool = false
    var year: Int = 0
    var month: Int = 0
    var day: Int = 0
    var id: String = ""
    var calories: Float = 0
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var plusButton: UIBarButtonItem!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        if(isDone){
            
            self.plusButton.title = "Done"
            self.plusButton.action = #selector(MealItensTableViewController.Done)
        }
        else{
            self.plusButton.action = #selector(MenuTableViewController.insert)
        }
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(MenuTableViewController.insert))
        
        let getResults = self.getMenus()
        for result in getResults.enumerated() {
            allMenusRealm.append(result.element)
            allMenus.append(self.changeMenuType(result: result.element))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    // -----------------------------------Table View ------------------------
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allMenus.count
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MenuTableViewCell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuTableViewCell
        
        let monthName = self.convert(month: allMenus[indexPath.row].month)
        
        cell.monthLabel.text = monthName
        cell.yearLabel.text = String(allMenus[indexPath.row].year)
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.actualMenu = allMenus[indexPath.row]
        self.isDone = false
        self.performSegue(withIdentifier: "individualMenu", sender: indexPath.row)
    }
    
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
    
            
            self.allMenusRealm[indexPath.row].delete()
            self.allMenusRealm.remove(at: indexPath.row)
            
            let getResults = self.getMeals()
            for result in getResults.enumerated() {
                if actualMenu.id == result.element.id{
                    result.element.delete()
                }
            }
            
            let getItemResults = self.getItens()
            for result in getItemResults.enumerated() {
                let menuID = result.element.id.components(separatedBy: "/")
                if actualMenu.id == menuID[0]{
                    result.element.delete()
                }
            }
            
            self.allMenus.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    //------------------------------- Navigation ---------------------------------
    
    @IBAction func backButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Home") as UIViewController
        present(vc, animated: true, completion: nil)
    }
    
    
    func insert(){
        performSegue(withIdentifier: "newMenu", sender: self)
    }
    
    func Done(){
        performSegue(withIdentifier: "backHome", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MealTableViewController{
            destination.actualMenu = self.actualMenu
        }
        if let destination = segue.destination as? NewMenuViewController{
            destination.actualMenu = self.actualMenu
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    /*
     func getContext () -> NSManagedObjectContext {
     let appDelegate = UIApplication.shared.delegate as! AppDelegate
     return appDelegate.persistentContainer.viewContext
     }
     */
    // Override to support editing the table view.
    
    
    //------------------------------- REALM ---------------------------------
    
    
    func getMenus() -> Results<MenuRealm> {
        do {
            let realm = try Realm()
            return realm.objects(MenuRealm.self)
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
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
    
    func changeMenuType(result: MenuRealm) -> Menu{
        
        let changeMenu: Menu = Menu(year: 0, month: 0, day: 0, calories: 0, id: "")
        
        changeMenu.day = result.day
        changeMenu.month = result.month
        changeMenu.year = result.year
        changeMenu.totalCalories = result.totalCalories
        changeMenu.id = result.id
        
        return changeMenu
    }
    
    //------------------------------- Logic ---------------------------------
    
    
    func convert(month: Int) -> String{
        switch month {
        case 1:
            return "January"
        case 2:
            return "February"
        case 3:
            return "March"
        case 4:
            return "April"
        case 5:
            return "May"
        case 6:
            return "June"
        case 7:
            return "July"
        case 8:
            return "August"
        case 9:
            return "September"
        case 10:
            return "October"
        case 11:
            return "November"
        case 12:
            return "December"
            
        default:
            print("erro")
        }
        return""
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
