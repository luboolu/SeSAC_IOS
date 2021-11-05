//
//  ListTableViewCell.swift
//  SeSAC_MYSHOPPINGLIST
//
//  Created by 김진영 on 2021/11/04.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var listLabel: UILabel!
    
    var favorite : (() -> ()) = {}
    var check : (() -> ()) = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func favoriteButtonClicked(_ sender: UIButton) {
        print(#function)
        favorite() //closure 호출
    }
    
    @IBAction func checkButtonClicked(_ sender: UIButton) {
        print(#function)
        check()
    }

}
