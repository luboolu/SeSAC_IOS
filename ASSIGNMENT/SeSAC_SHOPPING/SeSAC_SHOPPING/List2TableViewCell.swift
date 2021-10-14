//
//  List2TableViewCell.swift
//  SeSAC_SHOPPING
//
//  Created by 김진영 on 2021/10/13.
//

import UIKit

class List2TableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var shopListLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
