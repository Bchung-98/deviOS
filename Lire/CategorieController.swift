//
//  CategorieController.swift
//  Lire
//
//  Created by ManGart on 22/11/2018.
//  Copyright © 2018 ManGart. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CategorieController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var pickerView: UIPickerView!

    let categorie = ["Thriller", "Fantasy", "SF", "Horreur", "Humour"]
    var categorySelected: String = "Thriller"
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categorie.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categorie[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categorySelected = categorie[row]
    }
    
    @IBAction func continueButton(_ sender: UIButton) {
        let ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        
        ref.child("users").child(userID!).updateChildValues(["categorySelected" : categorySelected])
    }
    @IBAction func logout(_ sender: UIButton) {
        do{
            try Auth.auth().signOut()
            dismiss(animated: true, completion: nil)
        } catch {
            print("impossible de déconnecter l'utilisateur")
        }
    }
}
