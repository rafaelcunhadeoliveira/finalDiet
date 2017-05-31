//
//  IndividualMeasureVC.swift
//  DietFinal
//
//  Created by Rafael Cunha de Oliveira on 18/05/17.
//  Copyright © 2017 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit

class IndividualMeasureVC: UIViewController {

    
    @IBOutlet weak var chestLabel: UILabel!
    
    @IBOutlet weak var waistLabel: UILabel!
    
    @IBOutlet weak var hipsLabel: UILabel!
    
    @IBOutlet weak var rightArmLabel: UILabel!
    
    @IBOutlet weak var leftArmLabel: UILabel!
    
    @IBOutlet weak var rightThighLabel: UILabel!
    
    @IBOutlet weak var leftThighLabel: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
    
    var actualMeasure: Measure = Measure(year: 0, month: 0, day: 0)

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chestLabel.text = String(actualMeasure.chest)
        waistLabel.text = String(actualMeasure.waist)
        hipsLabel.text = String(actualMeasure.hips)
        leftArmLabel.text = String(actualMeasure.leftArm)
        rightArmLabel.text = String(actualMeasure.rightArm)
        leftThighLabel.text = String(actualMeasure.leftThigh)
        rightThighLabel.text = String(actualMeasure.rightThigh)
        weightLabel.text = String(actualMeasure.weight)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
    // MARK: - Navigation
     

     @IBAction func backButton(_ sender: Any) {
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

}
