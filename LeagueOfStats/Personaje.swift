//
//  Personaje.swift
//  LeagueOfStats
//
//  Created by DAM on 23/3/17.
//  Copyright © 2017 Sheila. All rights reserved.
//

import UIKit

class Personaje: NSObject {
    var champName : String
    var id : Int
    
    init(champName: String, id: Int) {
        self.champName = champName
        self.id = id
    }
    override init(){
        champName = ""
        id = 0
    }
}
