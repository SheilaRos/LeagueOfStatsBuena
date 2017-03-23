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
    var idRow = 0
    var nameChamp = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
