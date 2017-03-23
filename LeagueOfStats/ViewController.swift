//
//  ViewController.swift
//  LeagueOfStats
//
//  Created by DAM on 2/3/17.
//  Copyright © 2017 Sheila. All rights reserved.
//

import UIKit
var champNames = [Personaje]()
var partidas = [Partida]()
class ViewController: UIViewController, URLSessionDelegate {
    
    @IBOutlet weak var textoInvocador: UITextField!
    var palabra = ""
    var id = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        downloadChampNames()
    }
    @IBAction func entrar(_ sender: Any) {
        if partidas.count>0{
            partidas = [Partida]()
        }
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
                    for i in 0...allGames.count-1 {
                    let game = allGames[i]
                        var gameMode : String
                        if (game["gameMode"] != nil){
                            gameMode = game["gameMode"]! as! String
                        }else{
                            gameMode = "Null"
                        }
                    let stats = game["stats"] as! [String: Any]
                        var playerPosition : Any
                        if(stats["playerPosition"] != nil){
                            playerPosition = stats["playerPosition"]!
                            if(playerPosition as! Int == 1){
                                playerPosition = "TOP"
                            }else if(playerPosition as! Int == 2){
                                playerPosition = "MIDDLE"
                            }else if(playerPosition as! Int == 3){
                                playerPosition = "JUNGLE"
                            }else if(playerPosition as! Int == 4){
                                playerPosition = "BOT"
                                let playerRole = stats["playerRole"]!
                                if(playerRole as! Int == 2){
                                    playerPosition = "SUPPORT"
                                }
                                if(playerRole as! Int == 3){
                                    playerPosition = "CARRY"
                                }
                            }
                        }else{
                            playerPosition = "NUL"
                        }
                        var win : Any
                        if((stats["win"]) != nil){
                            win = stats["win"]!
                        }else{
                            win = "NUL"
                        }
                        var championId : Any
                        if((game["championId"]) != nil){
                            championId = game["championId"]!
                        }else{
                            championId = 1
                        }
                        var gameId : Any
                        if((game["gameId"]) != nil){
                            gameId = game["gameId"]!
                        }else{
                            gameId = 1
                        }
                        var minionsKilled : Any
                        if((stats["minionsKilled"]) != nil){
                            minionsKilled = stats["minionsKilled"]!
                        }else{
                            minionsKilled = 2
                        }
                        var goldEarned : Any
                        if((stats["goldEarned"]) != nil){
                            goldEarned = stats["goldEarned"]!
                        }else{
                            goldEarned = 1
                        }
                        var wardPlaced : Any
                        if((stats["wardPlaced"]) != nil){
                            wardPlaced = stats["wardPlaced"]!
                        }else{
                            wardPlaced = 1
                        }
                        var championsKilled : Any
                        if((stats["championsKilled"]) != nil){
                            championsKilled = stats["championsKilled"]!
                        }else{
                            championsKilled = 0
                        }
                        var assists : Any
                        if((stats["assists"]) != nil){
                            assists = stats["assists"]!
                        }else{
                            assists = 0
                        }
                        var numDeaths : Any
                        if((stats["numDeaths"]) != nil){
                            numDeaths = stats["numDeaths"]!
                        }else{
                            numDeaths = 0
                        }
                        var kda : Double
                        if (((assists as! Int) == 0) || ((championsKilled as! Int) == 0) || ((numDeaths as! Int) == 0)){
                            if(((assists as! Int) == 0)){
                                assists = 0.0
                            }
                            if(((championsKilled as! Int) == 0)){
                                championsKilled = 0.0
                            }
                            if(((numDeaths as! Int) == 0)){
                                numDeaths = 0.0
                            }
                        }
                        
                            kda = ((championsKilled  as! Double) + (assists  as! Double)) / (numDeaths as! Double)
                        if(((assists as! Double) == 0)){
                            assists = 0 as! Int
                        }
                        if(((championsKilled as! Double) == 0)){
                            championsKilled = 0 as! Int
                        }
                        if(((numDeaths as! Double) == 0)){
                            numDeaths = 0 as! Int
                        }
                    var partida : Partida = Partida ();
                        
                    partida.win = win as! Bool
                    partida.champ = championId as! Int
                    partida.type = gameMode 
                    partida.id = gameId as! CLong
                    partida.lane = playerPosition as! String
                    partida.minions = minionsKilled as! Int
                    partida.gold = goldEarned as! Int
                    partida.wards = wardPlaced as! Int
                    partida.kda = kda
                    partida.kills = championsKilled as! Int
                    partida.death = numDeaths as! Int
                    partida.assists = assists as! Int
                    partidas.append(partida)
                    }
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
    func downloadChampNames(){
        let url = URL(string: "https://global.api.riotgames.com/api/lol/static-data/EUW/v1.2/champion?dataById=true&locale=es_ES&api_key=RGAPI-3a39327e-3d10-42c6-87b6-eb4ef96168a3")
        let request = URLRequest(url: url!)
        
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            if (statusCode == 200){
                do {
                    let json = try JSONSerialization.jsonObject(with: data) as! [String:Any]
                    let data = json["data"] as! [String:Any]
                    
                    for i in 0...data.count-1 {
                        if data[String(i)] != nil{
                        let info = data[String(i)] as! [String:Any]
                        let champName = info["name"]!
                        let id = info["id"]!
                            var personaje : Personaje = Personaje();
                            personaje.champName = champName as! String
                            personaje.id = id as! Int
                            champNames.append(personaje)
                            print(personaje)
                        }
                    }
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

