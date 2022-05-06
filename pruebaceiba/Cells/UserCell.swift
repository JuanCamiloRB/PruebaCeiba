//
//  UserCell.swift
//  pruebaceiba
//
//  Created by Juan Camilo Rodriguez Betacourt on 4/05/22.
//

import UIKit
protocol UserCellCellDelegate: class {
    func btnPosts(sender: UIButton,at index:IndexPath)
}

class UserCell: UITableViewCell {

    @IBOutlet weak var posBtn: UIButton!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!

    @IBOutlet weak var imgEmail: UIImageView!
    @IBOutlet weak var imgPhone: UIImageView!
    weak var delegate: UserCellCellDelegate?
    var indexPath:IndexPath!
    
    @IBAction func btnPostAction(_ sender: UIButton) {
        delegate?.btnPosts(sender: sender, at: indexPath)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
