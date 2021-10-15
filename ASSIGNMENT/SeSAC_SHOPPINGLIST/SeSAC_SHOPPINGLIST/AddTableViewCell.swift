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
        
        if addText != "" {
            
            let defaults = UserDefaults.standard
            //저장된 userDefault 값 가져오기
            var shopList = defaults.array(forKey: "list") as? [String] ?? []

            //새로 추가할 값
            shopList.append(addText)
            //추가된 데이터를 userdefault에 저장
            defaults.set(shopList, forKey: "list")
            var newShopList = defaults.array(forKey: "list") as? [String] ?? []
            print(newShopList)
            
            //데이터 입력이 완료되면, textfield 초기화
            addTextField.text = ""
            

        }
        

    }
}
