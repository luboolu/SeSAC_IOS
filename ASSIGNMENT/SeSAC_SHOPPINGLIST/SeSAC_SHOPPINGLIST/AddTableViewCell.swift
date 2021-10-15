//
//  AddTableViewCell.swift
//  SeSAC_SHOPPINGLIST
//
//  Created by 김진영 on 2021/10/14.
//

import UIKit

class AddTableViewCell: UITableViewCell {
    
    @IBOutlet weak var addTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func addButtonClicked(_ sender: UIButton) {
        let addText = addTextField.text!
        
        print("\(addText) add button clicked")
        
        
        
    }
}
