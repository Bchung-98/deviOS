//
//  HomeController.swift
//  Lire
//
//  Created by ManGart on 22/11/2018.
//  Copyright © 2018 ManGart. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class HomeController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
//OUTLETS
    @IBOutlet weak var hi: UILabel!
    var time = ["5 min", "10 min", "15 min", "30 min", "45 min", "60 min"]
    var timeSelected: String = "5 min"
    override func viewDidLoad() {
        super.viewDidLoad()

        if let user = Auth.auth().currentUser {
            let ref = Database.database().reference()
            let userID = Auth.auth().currentUser?.uid
            
            ref.child("users").child(userID!).observeSingleEvent(of: .value){ (snapshot) in
                let value = snapshot.value as? NSDictionary
                
                let username = value?["username"] as? String ?? "no username"
                
                self.hi.text = "Bonjour, " + username
            }
            
        } else {
            fatalError("Aucun utilisateur est connecté !")
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return time.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return time[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        timeSelected = time[row]
    }
    
    @IBAction func continueButton(_ sender: UIButton) {
        let ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        
        ref.child("users").child(userID!).updateChildValues(["timeSelected" : timeSelected])
        
    }
}
