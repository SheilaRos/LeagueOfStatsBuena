//
//  TableViewController.swift
//  LeagueOfStats
//
//  Created by DAM on 7/3/17.
//  Copyright © 2017 Sheila. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return partidas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! TableViewCell
        if partidas[indexPath.row].win {
            cell.win.text = "Win"
            cell.win.textColor = UIColor(red:0.08, green:0.71,blue:0.08,alpha:1.0)
        }else{
            cell.win.text = "Default"
            cell.win.textColor = UIColor.red
        }
        cell.lane.text = partidas[indexPath.row].lane + " lane"
        cell.type.text = partidas[indexPath.row].type
        let imagenes = String(partidas[indexPath.row].champ) + ".png"
        cell.champImage.image = UIImage (named: imagenes)
        for i in 0...champNames.count-1 {
            if champNames[i].id == partidas[indexPath.row].champ {
                cell.champ.text = champNames[i].champName
            }
        }
        if (indexPath.row % 2) == 0{
            cell.backgroundColor = tableView.backgroundColor
        }else{
            cell.backgroundColor = UIColor(red:0.93, green:0.93,blue:0.93,alpha:1.0)
        }
        
        return cell
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var detalle: InfoPartida = segue.destination as! InfoPartida
        detalle.idRow = (tableView.indexPathForSelectedRow?.row)!
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
