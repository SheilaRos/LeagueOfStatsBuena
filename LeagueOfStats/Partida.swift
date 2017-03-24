//
//  Partida.swift
//  LeagueOfStats
//
//  Created by DAM on 7/3/17.
//  Copyright © 2017 Sheila. All rights reserved.
//

import UIKit

class Partida: NSObject {
    var champ : Int
    var type : String
    var id : CLong
    var lane : String
    var win: Bool
    var minions : Int
    var gold: Int
    var wards : Int
    var kda : Double
    var kills : Int
    var assists : Int
    var death : Int

    
    init(champ: Int, type: String, id: CLong, lane: String, win: Bool, minions: Int, gold: Int, wards: Int, kills: Int, assists: Int, death: Int, kda: Double) {
        self.champ = champ
        self.type = type
        self.id = id
        self.lane = lane
        self.win = win
        self.minions = minions
        self.gold = gold
        self.wards = wards
        self.kills = kills
        self.assists = assists
        self.death = death
        self.kda = kda

    }
    
    override init() {
        champ = 0
        type = ""
        id = 0
        lane = ""
        win = false
        minions = 0
        gold = 0
        wards = 0
        kda = 0.0
        kills = 0
        assists = 0
        death = 0
    }

    
}
