//
//  ShoppingTableViewController.swift
//  SeSAC_SHOPPINGLIST
//
//  Created by 김진영 on 2021/10/14.
//

import UIKit

class ShoppingTableViewController: UITableViewController {

    @IBOutlet weak var ShoppingTableViewTitle: UILabel!
    
    var list: [String] = UserDefaults.standard.string(forKey: "shopping")! {
        didSet {
            print("\(oldValue) -> \(list)")
        }
    }
    
    
    var shoppingList: [String] = ["첫번째 목록", "두번째 목록"] {
        didSet {
            //shoppingList의 내용이 변화하면 변화한 내용을 userdefaults에 저장하고 화면에 띄운다.
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "addCell") as? AddTableViewCell else {
                return UITableViewCell()
            }
            
            cell.backgroundColor = .lightGray
            cell.addButton.backgroundColor = .gray
            cell.addButton.setTitle("추가", for: .normal)
            cell.addButton.setTitleColor(.white, for: .normal)
            cell.addButton.layer.cornerRadius = 5
            
            cell.addTextField.backgroundColor = .lightGray
            cell.addTextField.placeholder = "무엇을 구매하실 건가요?"
            cell.addTextField.borderStyle = .none
            
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "listCell") as? ListTableViewCell else {
                return UITableViewCell()
            }
            
            cell.backgroundColor = .yellow

            
            return cell
        }
        

        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 60 : 44
    }
    


}
