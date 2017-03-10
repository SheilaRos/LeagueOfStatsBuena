//
//  ViewController.swift
//  LeagueOfStats
//
//  Created by DAM on 2/3/17.
//  Copyright © 2017 Sheila. All rights reserved.
//

import UIKit

class ViewController: UIViewController, URLSessionDelegate {
    
    @IBOutlet weak var textoInvocador: UITextField!
    var palabra = ""
    var id = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func entrar(_ sender: Any) {
        
        var invocador  = textoInvocador.text!.lowercased()
        var letras = Array(invocador.characters)
        var volcado = [Character]()
        if invocador.isEmpty {
        }else{
            for i in 0...letras.count-1 {
                if (letras[i] != " ") {
                    volcado.append(letras[i])
                }
            }
            palabra = String(volcado)
            downloadPlayerId()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        self.show(TableViewController() as UIViewController, sender: self)
    }
    func downloadPlayerId(){
        let url = URL(string: "https://euw.api.pvp.net/api/lol/euw/v1.4/summoner/by-name/" + palabra + "?api_key=RGAPI-3a39327e-3d10-42c6-87b6-eb4ef96168a3")
        let request = URLRequest(url: url!)

        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            if (statusCode == 200){
                do {
                    let json = try JSONSerialization.jsonObject(with: data) as! [String:Any]
                    let summoner = json[self.palabra] as! [String:Any]
                    print(summoner)
                    let getid = summoner["id"]!
                    self.id = String(describing: getid)
                    print(self.id)
                    self.downloadPlayerInfo()
                } catch let error as NSError {
                    print(error)
                }
            }else if(statusCode == 404){
                print("No existe el usuario")
            }else{
                print("Error desconocido")
            }
        }).resume()
        
    }
    func downloadPlayerInfo(){
        let url = URL(string: "https://euw.api.pvp.net/api/lol/euw/v1.3/game/by-summoner/" + id + "/recent?api_key=RGAPI-3a39327e-3d10-42c6-87b6-eb4ef96168a3")
        let request = URLRequest(url: url!)
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            if (statusCode == 200){
                do {
                    let json = try JSONSerialization.jsonObject(with: data) as! [String:Any]
                    let allGames = json["games"] as! [[String:Any]]
                    let game = allGames[0]
                    let gameMode = game["gameMode"]!
                    let stats = game["stats"] as! [String: Any]
                    var playerPosition = stats["playerPosition"]!
                    
                    if(playerPosition as! Int == 1){
                        playerPosition = "TOP"
                    }else if(playerPosition as! Int == 2){
                        playerPosition = "MIDDLE"
                    }else if(playerPosition as! Int == 3){
                        playerPosition = "JUNGLE"
                    }else if(playerPosition as! Int == 4){
                        playerPosition = "BOT"
                        let playerRole = game["playerRole"]!
                        if(playerRole as! Int == 2){
                            playerPosition = "SUPPORT"
                        }
                        if(playerRole as! Int == 3){
                            playerPosition = "CARRY"
                        }
                    }
                    let win = stats["win"]!
                    let championId = game["championId"]!
                    print(gameMode)
                    print(playerPosition)
                    print(win)
                    print(championId)
                    
                } catch let error as NSError {
                    print(error)
                }
            
            }else if(statusCode == 404){
                print("No existe el usuario")
            }else{
                print("Error desconocido")
            }
        }).resume()
    }
    
}

