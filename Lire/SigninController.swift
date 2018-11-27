//
//  SigninController.swift
//  Lire
//
//  Created by ManGart on 22/11/2018.
//  Copyright © 2018 ManGart. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SigninController: UIViewController, UITextFieldDelegate {
//OUTLETS
    @IBOutlet weak var prenom: UITextField!
    @IBOutlet weak var nom: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLabels()
    }
    
//FUNCTIONS
    private func setUpLabels(){
        var greenColor = UIColor(red: 68.0/255.0, green: 219.0/255.0, blue: 94.0/255.0, alpha: 1.0).cgColor
        prenom.layer.borderWidth = 2
        prenom.layer.cornerRadius = 20
        prenom.layer.borderColor = greenColor
        nom.layer.borderWidth = 2
        nom.layer.cornerRadius = 20
        nom.layer.borderColor = greenColor
        username.layer.borderWidth = 2
        username.layer.cornerRadius = 20
        username.layer.borderColor = greenColor
        password.layer.borderWidth = 2
        password.layer.cornerRadius = 20
        password.layer.borderColor = greenColor
        email.layer.borderWidth = 2
        email.layer.cornerRadius = 20
        email.layer.borderColor = greenColor
        
    }
    
    private func textFieldManager(){
        prenom.delegate = self
        nom.delegate = self
        username.delegate = self
        password.delegate = self
        email.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
//ACTIONS
    @objc private func hideKeyboard() {
        prenom.resignFirstResponder()
        nom.resignFirstResponder()
        username.resignFirstResponder()
        password.resignFirstResponder()
        email.resignFirstResponder()
    }
    
    @IBAction func createAccount(_ sender: UIButton) {
        if prenom.text != "" && nom.text != "" && username.text != "" && password.text != "" && email.text != "" {
            Auth.auth().createUser(withEmail: email.text! , password: password.text! ){(authResult, error) in
                if error != nil {
                    print(error.debugDescription)
                } else {
                    let ref = Database.database().reference()
                    let userID = Auth.auth().currentUser?.uid
                    ref.child("users").child(userID!).setValue(["prenom" : self.prenom.text, "nom" : self.nom.text, "username" : self.username.text, "email" : self.email.text])
                    
                    self.performSegue(withIdentifier: "connexion", sender: self)
                }
            }
        }
    }
}
