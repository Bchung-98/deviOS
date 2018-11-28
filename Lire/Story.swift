//
//  Story.swift
//  Lire
//
//  Created by ManGart on 28/11/2018.
//  Copyright © 2018 ManGart. All rights reserved.
//

import UIKit

class Story: NSObject {

    let auteur: String
    let categorie: String
    let contenu: String
    let temps: Int
    let titre: String
    
    init(apiStory : NSDictionary) {
        self.auteur = apiStory["author"] as! String
        self.categorie = apiStory["category"] as! String
        self.contenu = apiStory["content"] as! String
        self.temps = apiStory["time"] as! Int
        self.titre = apiStory["title"] as! String
    }

}
