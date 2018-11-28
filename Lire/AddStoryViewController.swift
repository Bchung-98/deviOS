//
//  AddStoryViewController.swift
//  Lire
//
//  Created by ManGart on 28/11/2018.
//  Copyright © 2018 ManGart. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class AddStoryViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var timeStory: UILabel!
    @IBOutlet weak var categoryStory: UIPickerView!
    @IBOutlet weak var contentStory: UITextView!
    @IBOutlet weak var titleStory: UITextField!
    let categorie = ["Thriller", "Fantasy", "SF", "Horreur", "Humour"]
    var categorySelected: String = "Thriller"
    var greenColor = UIColor(red: 68.0/255.0, green: 219.0/255.0, blue: 94.0/255.0, alpha: 1.0).cgColor
    var number = 0
    var authorStory: String = "authorName"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryStory.selectRow(2, inComponent:0, animated:true)
        setUpStyle()
        let ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        
        ref.child("users").child(userID!).observeSingleEvent(of: .value){ (snapshot) in
            let value = snapshot.value as? NSDictionary
            let author = value?["username"] as? String ?? "no username"
            
            self.authorStory = author
        }
    }
    
    private func setUpStyle(){
        titleStory.layer.borderWidth = 1
        titleStory.layer.cornerRadius = 5
        titleStory.layer.borderColor = greenColor
        contentStory.layer.borderWidth = 1
        contentStory.layer.cornerRadius = 10
        contentStory.layer.borderColor = greenColor
        
    }
    
    @IBAction func stepperForTime(_ sender: UIStepper) {
        
        self.number = Int(sender.value)
        timeStory.text = String(number)
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
    
    @IBAction func addStory(_ sender: UIButton) {
        let ref = Database.database().reference()
        
        ref.child("story").childByAutoId().updateChildValues(["author" : authorStory, "category" : categorySelected, "content" : contentStory.text, "time" : number, "title" : titleStory.text])
    }
    
}
