//
//  DefaultTableViewCell.swift
//  SeSAC_WEEK4
//
//  Created by 김진영 on 2021/10/18.
//

import UIKit

class DefaultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    
    static let identifier = "DefaultTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
