//
//  FeedCell.swift
//  ParseFotografUygulamasi
//
//  Created by İbrahim Güler on 25.07.2021.
//

import UIKit

class FeedCell: UITableViewCell {
    @IBOutlet weak var postEmailText: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postYorumText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
