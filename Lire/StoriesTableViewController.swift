//
//  StoriesTableViewController.swift
//  Lire
//
//  Created by ManGart on 22/11/2018.
//  Copyright © 2018 ManGart. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore

class StoriesTableViewController: UITableViewController{
   
    var allMyStories: [Story] = [Story]()
    @IBOutlet var tableview: UITableView!
    var categorySelected: String = ""
    var timeSelected: Int = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        let ref = Database.database().reference()
        let userID = Auth.auth().currentUser?.uid
        
        ref.child("users").child(userID!).observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let categoryData = value?["categorySelected"] as? String
            
            self.categorySelected = categoryData ?? "Thriller"
        }
        
        ref.child("users").child(userID!).observeSingleEvent(of: .value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let timeData = value?["timeSelected"] as? String
            
            if (timeData == "5 min"){
                self.timeSelected = 5
            }else if (timeData == "10 min"){
                self.timeSelected = 10
            }else if (timeData == "15 min"){
                self.timeSelected = 15
            }else if (timeData == "20 min"){
                self.timeSelected = 20
            }else if (timeData == "30 min"){
                self.timeSelected = 30
            }else if (timeData == "45 min"){
                self.timeSelected = 45
            }else{
                self.timeSelected = 60
            }
        }
        
        ref.child("story").observeSingleEvent(of: .value) { (snapshot) in
            if let stories = snapshot.value as? NSDictionary {
                for key in stories.allKeys {
                    let story = stories[key]
                    if let apiStory = story as? NSDictionary {
                        let realStory = Story(apiStory: apiStory)//consctruu NSDictionary param
                        if(realStory.categorie == self.categorySelected && realStory.temps <= self.timeSelected){
                            self.allMyStories.append(realStory)
                            print(apiStory["author"] ?? String())
                        }
                    }
                }
            }
            self.tableview.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("finish")
        print(allMyStories.count)
        return allMyStories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let storyCell = tableView.dequeueReusableCell(withIdentifier: "storyCell", for: indexPath)as! StoryTableViewCell
        storyCell.titleLabel.text = allMyStories[indexPath.row].titre
        storyCell.auteurLabel.text = "Auteur: \(allMyStories[indexPath.row].auteur)"
        
        return storyCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let uniqueStory = allMyStories[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailController = storyboard.instantiateViewController(withIdentifier: "DetailStoryViewController") as! DetailStoryViewController
        detailController.story = uniqueStory
        
        navigationController?.pushViewController(detailController, animated: true)

    }
    
}

