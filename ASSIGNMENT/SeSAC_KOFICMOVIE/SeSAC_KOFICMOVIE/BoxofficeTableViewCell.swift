//
//  BoxofficeTableViewCell.swift
//  SeSAC_KOFICMOVIE
//
//  Created by 김진영 on 2021/11/02.
//

import UIKit

class BoxofficeTableViewCell: UITableViewCell {
    
    static let identifier = "BoxofficeTableViewCell"
    
    
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
