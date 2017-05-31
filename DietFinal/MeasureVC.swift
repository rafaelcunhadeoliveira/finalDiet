//
//  MeasureVC.swift
//  DietFinal
//
//  Created by Rafael Cunha de Oliveira on 17/05/17.
//  Copyright © 2017 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit
import Realm
import RealmSwift

class MeasureVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var allMeasures: Array<Measure> = []
    var allMeasuresRealm: Array<MeasureRealm> = []
    var actualMeasure: Measure = Measure(year: 0, month: 0, day: 0)
    
    @IBOutlet weak var tableView: UITableView!
    var year: Int = 0
    var month: Int = 0
    var day: Int = 0
    var chest: Float = 0
    var waist: Float = 0
    var hips: Float = 0
    var leftArm: Float = 0
    var rightArm: Float = 0
    var leftThigh: Float = 0
    var rightThigh: Float = 0
    var weight: Float = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let getResults = self.getMeasures()
        for result in getResults.enumerated() {
            allMeasuresRealm.append(result.element)
            allMeasures.append(self.changeMeasureType(result: result.element))
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //--------- Table View Controller
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allMeasures.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: measureCell = tableView.dequeueReusableCell(withIdentifier: "measureCell", for: indexPath) as! measureCell
        let monthName = self.convert(month: allMeasures[indexPath.row].month)
        cell.monthLabel.text = monthName
        cell.yearLabel.text = String(allMeasures[indexPath.row].year)
        cell.dayLabel.text = String(allMeasures[indexPath.row].day)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.actualMeasure = allMeasures[indexPath.row]
        self.performSegue(withIdentifier: "goToIndividual", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {

            self.allMeasuresRealm[indexPath.row].delete()
            self.allMeasuresRealm.remove(at: indexPath.row)
            self.allMeasures.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
 // ---------- Realm -------------
    
    func getMeasures() -> Results<MeasureRealm> {
        do {
            let realm = try Realm()
            return realm.objects(MeasureRealm.self)
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    
    func changeMeasureType(result: MeasureRealm) -> Measure{
        
        let changeMeasure: Measure = Measure(year: 0, month: 0, day: 0)
        
        changeMeasure.chest = result.chest
        changeMeasure.waist = result.waist
        changeMeasure.hips = result.hips
        changeMeasure.leftArm = result.leftArm
        changeMeasure.rightArm = result.rightArm
        changeMeasure.leftThigh = result.leftThigh
        changeMeasure.rightThigh = result.rightThigh
        changeMeasure.year = result.year
        changeMeasure.month = result.month
        changeMeasure.day = result.day
        changeMeasure.weight = result.weight
        
        return changeMeasure
    }
    
  // ====== logic ------
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

    
    
 // ---------- Navigation -------------
    
    @IBAction func backButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Home") as UIViewController
        present(vc, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? IndividualMeasureVC{
            destination.actualMeasure = self.actualMeasure
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

}
