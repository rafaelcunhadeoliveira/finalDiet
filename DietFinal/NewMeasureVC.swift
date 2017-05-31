//
//  NewMeasureVC.swift
//  DietFinal
//
//  Created by Rafael Cunha de Oliveira on 17/05/17.
//  Copyright © 2017 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit

class NewMeasureVC: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var chestField: UITextField!
    @IBOutlet weak var waistField: UITextField!
    @IBOutlet weak var hipsField: UITextField!
    @IBOutlet weak var rightArmField: UITextField!
    @IBOutlet weak var leftArmField: UITextField!
    @IBOutlet weak var rightThighField: UITextField!
    @IBOutlet weak var leftThighField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    
    var chestValue: Float = 0
    var waistValue: Float = 0
    var hipsValue: Float = 0
    var rightArmValue: Float = 0
    var leftArmValue: Float = 0
    var rightThighValue: Float = 0
    var leftThighValue: Float = 0
    var weightValue: Float = 0
    
    var year: Int = 0
    var month: Int = 0
    var day: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboard()
        self.addNotification()
        self.setDatePicker()
        self.initiateFields()
    }
    // Do any additional setup after loading the view.
    
    
    // ----- Set -------
    func addNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -200 // Move view 150 points upward
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initiateFields(){
        self.chestField.keyboardType = UIKeyboardType.decimalPad
        self.waistField.keyboardType = UIKeyboardType.decimalPad
        self.hipsField.keyboardType = UIKeyboardType.decimalPad
        self.rightArmField.keyboardType = UIKeyboardType.decimalPad
        self.leftArmField.keyboardType = UIKeyboardType.decimalPad
        self.rightThighField.keyboardType = UIKeyboardType.decimalPad
        self.leftThighField.keyboardType = UIKeyboardType.decimalPad
        self.weightField.keyboardType = UIKeyboardType.decimalPad
    }
    
    // -------- Scroll View --------
    
    
    
    // -------- date picker --------
    
    func setDatePicker(){
        datePicker.datePickerMode = UIDatePickerMode.date
        datePicker.addTarget(self, action: #selector(dateTarget), for: UIControlEvents.valueChanged)
        let actualDate = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: actualDate)
        
        year =  components.year!
        month = components.month!
        day = components.day!
    }
    
    @IBAction func dateTarget (sender: UIDatePicker){
        let date = sender.date
        let calendar = Calendar.current
        
        year = calendar.component(.year, from: date)
        month = calendar.component(.month, from: date)
        day = calendar.component(.day, from: date)
    }
    
    // MARK: - Navigation
    
    @IBAction func BackButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Measure", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Measures") as UIViewController
        present(vc, animated: true, completion: nil)
    }
    /*
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func saveButton(_ sender: Any) {
        self.getDataFromFields()
        self.saveMeasure()
        
        
        
        let alert = UIAlertController(title: "", message: "Your new measure is saved", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {action in self.pressed()}))
        
        self.present(alert, animated: true, completion: nil)

  
        
    }
    func pressed()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Home") as UIViewController
        present(vc, animated: true, completion: nil)
    }
    
    func getDataFromFields(){
        
        if verify(){
            
            if let chest = Float(chestField.text!),
            let waist = Float(waistField.text!),
            let hips = Float(hipsField.text!),
            let rightArm = Float(rightArmField.text!),
            let leftArm = Float(leftArmField.text!),
            let rightThigh = Float(rightThighField.text!),
            let leftThigh = Float(leftThighField.text!),
            let weight = Float(weightField.text!){
                self.chestValue = chest
                self.waistValue = waist
                self.hipsValue = hips
                self.rightArmValue = rightArm
                self.leftArmValue = leftArm
                self.rightThighValue = rightThigh
                self.leftThighValue = leftThigh
                self.weightValue = weight
            }
            else{
                let alert = UIAlertController(title: "Error", message: " Verify information provided ", preferredStyle: UIAlertControllerStyle.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        else{
            let alert = UIAlertController(title: "Error", message: "Some information missing ", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)

        }
        
    }
    
    func verify() -> Bool{
        
        if (chestField.text?.isEmpty)! || (waistField.text?.isEmpty)! || (hipsField.text?.isEmpty)! || (rightArmField.text?.isEmpty)! || (leftArmField.text?.isEmpty)! || (rightThighField.text?.isEmpty)! || (leftThighField.text?.isEmpty)! || (weightField.text?.isEmpty)! {
            
            
            
            return false
        }
        return true
        
    }
    

    
    func saveMeasure(){
        
        let new_Measure = MeasureRealm()
        
        new_Measure.chest = self.chestValue
        new_Measure.waist = self.waistValue
        new_Measure.hips = self.hipsValue
        new_Measure.leftArm = self.leftArmValue
        new_Measure.rightArm = self.rightArmValue
        new_Measure.leftThigh = self.leftThighValue
        new_Measure.rightThigh = self.rightThighValue
        new_Measure.year = self.year
        new_Measure.month = self.month
        new_Measure.day = self.day
        new_Measure.weight = self.weightValue
        
        new_Measure.save()
        
    }
    
}
