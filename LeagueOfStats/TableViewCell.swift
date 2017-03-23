//
//  TableViewCell.swift
//  LeagueOfStats
//
//  Created by DAM on 23/3/17.
//  Copyright © 2017 Sheila. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var champImage: UIImageView!
    @IBOutlet weak var win: UILabel!
    @IBOutlet weak var champ: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var lane: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
