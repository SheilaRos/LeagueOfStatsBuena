//
//  InfoPartida.swift
//  LeagueOfStats
//
//  Created by DAM on 7/3/17.
//  Copyright © 2017 Sheila. All rights reserved.
//

import UIKit

class InfoPartida: UIViewController {
    @IBOutlet weak var creepScore: UILabel!
    @IBOutlet weak var gold: UILabel!
    @IBOutlet weak var wards: UILabel!
    @IBOutlet weak var kdaRatio: UILabel!
    @IBOutlet weak var killsAssistsDeath: UILabel!
    @IBOutlet weak var progressGold: UIProgressView!
    
    @IBOutlet weak var progressScore: UIProgressView!

    @IBOutlet weak var progressKDA: UIProgressView!
    @IBOutlet weak var progressWards: UIProgressView!
    var idRow = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...champNames.count-1{
            if champNames[i].id == partidas[idRow].champ {
                navigationItem.title = champNames[i].champName
            }
        }
        creepScore.text = creepScore.text! + " " + String(partidas[idRow].minions)
        gold.text = gold.text! + " " + String(partidas[idRow].gold)
        wards.text = wards.text! + " " + String(partidas[idRow].wards)
        kdaRatio.text = kdaRatio.text! + " " + String(partidas[idRow].kda)
        print(partidas[idRow].kda)
        killsAssistsDeath.text = String(partidas[idRow].kills) + " Kills - " + String(partidas[idRow].death) + " Death - " + String(partidas[idRow].assists) + " Assists " 
        var minionsP : Double = Double (partidas[idRow].minions) * 100 / 30000
        if minionsP > 1.0{
            minionsP = 1.0
        }
        progressScore.progress =  Float(minionsP)
        var goldP : Double = Double (partidas[idRow].gold) * 100 / 1900000
        if goldP > 1.0{
            goldP = 1.0
        }
        progressGold.progress = Float(goldP)
        var kdaP : Double = 0.00
        if partidas[idRow].kda > 15{
            kdaP = 1.0
        }else{
            kdaP = Double (partidas[idRow].kda) * 100 / 1500
        }
        if kdaP > 1.0{
            kdaP = 1.0
        }

        progressKDA.progress = Float(kdaP)
        
        var wardP : Double = Double (partidas[idRow].wards) * 100 / 3500
        if wardP > 1.0{
            wardP = 1.0
        }
        progressWards.progress = Float(wardP)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
