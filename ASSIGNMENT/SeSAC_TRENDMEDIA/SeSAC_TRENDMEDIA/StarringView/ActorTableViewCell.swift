//
//  ActorTableViewCell.swift
//  SeSAC_TRENDMEDIA
//
//  Created by 김진영 on 2021/10/17.
//

import UIKit

class ActorTableViewCell: UITableViewCell {

    
    @IBOutlet weak var actorImageView: UIImageView!
    @IBOutlet weak var actorProfile1: UILabel!
    @IBOutlet weak var actorProfile2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
