//
//  PosterTableViewCell.swift
//  SeSAC_TRENDMEDIA
//
//  Created by 김진영 on 2021/10/17.
//

import UIKit

class PosterTableViewCell: UITableViewCell {

    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var rateNameLabel: UILabel!
    @IBOutlet weak var rateNumLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
