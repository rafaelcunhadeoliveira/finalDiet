//
//  Home.swift
//  DietFinal
//
//  Created by Rafael Cunha de Oliveira on 16/05/17.
//  Copyright © 2017 Rafael Cunha de Oliveira. All rights reserved.
//

import UIKit

class Home: UIViewController {

    @IBOutlet weak var measureButton: UIButton!
    @IBOutlet weak var menuButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        measureButton.adjustsImageWhenHighlighted = false
        menuButton.adjustsImageWhenHighlighted = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // -----Button actions------
    
    @IBAction func goToMeasures(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Measure", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Measures") as UIViewController
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func goToMenu(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "allMenus") as UIViewController
        present(vc, animated: true, completion: nil)
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

extension UIViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
