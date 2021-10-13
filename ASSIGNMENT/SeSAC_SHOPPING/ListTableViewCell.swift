//
//  ListTableViewCell.swift
//  SeSAC_SHOPPING
//
//  Created by 김진영 on 2021/10/13.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
