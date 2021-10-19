//
//  OverviewTableViewCell.swift
//  SeSAC_TRENDMEDIA
//
//  Created by 김진영 on 2021/10/19.
//

import UIKit

class OverviewTableViewCell: UITableViewCell {
    
    static let identifier = "OverviewTableViewCell"

    @IBOutlet var overviewLabel: UILabel!
    @IBOutlet var chevronButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
