
//
//  MealItensTableViewController.swift
//  MyDiet
//
//  Created by Rafael Cunha on 15/03/17.
//  Copyright © 2017 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class MealItensTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var items: Array<Item> = []
    var itemsRealm: Array<ItemRealm> = []
    var actualMeal: Meal = Meal(hour: 0, minute: 0, id: "")
    var actualMenu: Menu = Menu(year: 0, month: 0, day: 0, calories: 0, id: "")
    var itemName: String = ""
    var itemQuantity: String = ""
    var itemUnity: String = ""
    var itemID: String = ""
    var newItem = false
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    @IBOutlet weak var plusButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtons()

        itemID = actualMenu.id + "/" + String(actualMeal.hour) + String(actualMeal.minute) + actualMeal.type
        
        let getResults = self.getItens()
        for result in getResults.enumerated() {
            if self.itemID == result.element.id{
                itemsRealm.append(result.element)
                items.append(self.changeItensType(result: result.element))
            }
        }
    }
    
    func setButtons(){
        if(newItem){
            self.backButton.title = "Done"
            
        }
        self.backButton.action = #selector(self.Done)
        self.plusButton.action = #selector(self.insert)
    }
    
    func insert(){
        performSegue(withIdentifier: "newItem", sender: self)
    }
    
    func Done(){
        performSegue(withIdentifier: "isDone", sender: self)
    }
    func backAction() {
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "allMeals") as UIViewController
        present(vc, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? NewItemViewController{
            destination.actualMeal = self.actualMeal
            destination.actualMenu = self.actualMenu
        }
        if let destination = segue.destination as? MealTableViewController{
            destination.getID = self.actualMeal
            destination.actualMenu = self.actualMenu
            destination.isNew = newItem
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MealItensTableViewCell = tableView.dequeueReusableCell(withIdentifier: "itens", for: indexPath) as! MealItensTableViewCell
        
        cell.itemField.text = items[indexPath.row].name
        cell.quantityFIeld.text = items[indexPath.row].quantity
        cell.unityFIeld.text = items[indexPath.row].unity
        // Configure the cell...
        
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    

    
    
    // Override to support editing the table view.
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            
            self.itemsRealm[indexPath.row].delete()
            self.itemsRealm.remove(at: indexPath.row)
            self.items.remove(at: indexPath.row)
            tableView.reloadData()
        }
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
    
    func getItens() -> Results<ItemRealm> {
        do {
            let realm = try Realm()
            return realm.objects(ItemRealm.self)
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    func changeItensType(result: ItemRealm) -> Item{
        
        let changeItem: Item = Item(name: "", quantity: "", unity: "", id: "")
        
        changeItem.name = result.name
        changeItem.quantity = result.quantity
        changeItem.unity = result.unity
        changeItem.id = result.id
        
        return changeItem
    }
}
