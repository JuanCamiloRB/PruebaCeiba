//
//  PostViewCell.swift
//  pruebaceiba
//
//  Created by Juan Camilo Rodriguez Betacourt on 6/05/22.
//

import UIKit

class PostViewCell: UITableViewCell {
   
    @IBOutlet weak var postLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
