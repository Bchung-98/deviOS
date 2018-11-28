//
//  ViewController.swift
//  Lire
//
//  Created by ManGart on 21/11/2018.
//  Copyright © 2018 ManGart. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController, UITextFieldDelegate {
//OUTLETS
    @IBOutlet weak var usernameLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    var red = UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor
    var greenColor = UIColor(red: 68.0/255.0, green: 219.0/255.0, blue: 94.0/255.0, alpha: 1.0).cgColor
    
//PROPERTIES
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLabels()
        textFieldManager()
    }
    
//FUNCTIONS
    private func setUpLabels(){
        usernameLabel.layer.borderWidth = 2
        usernameLabel.layer.cornerRadius = 20
        usernameLabel.layer.borderColor = greenColor
        passwordLabel.layer.borderWidth = 2
        passwordLabel.layer.cornerRadius = 20
        passwordLabel.layer.borderColor = greenColor
        
    }
    
    private func textFieldManager(){
        usernameLabel.delegate = self
        passwordLabel.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
//ACTIONS
    @objc private func hideKeyboard() {
        usernameLabel.resignFirstResponder()
        passwordLabel.resignFirstResponder()
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        if usernameLabel.text != "" && passwordLabel.text != ""{
            Auth.auth().signIn(withEmail: usernameLabel.text!, password: passwordLabel.text!){(authResult, error) in
                if error != nil {
                    
                    self.usernameLabel.layer.borderColor = self.red
                    self.passwordLabel.layer.borderColor = self.red
                }else{
                    self.performSegue(withIdentifier: "goToHome", sender: self)
                    self.usernameLabel.layer.borderColor = self.greenColor
                    self.passwordLabel.layer.borderColor = self.greenColor
                }
            }
        }
    }
    
    @IBAction func createAccountButton(_ sender: UIButton) {
    }
}

