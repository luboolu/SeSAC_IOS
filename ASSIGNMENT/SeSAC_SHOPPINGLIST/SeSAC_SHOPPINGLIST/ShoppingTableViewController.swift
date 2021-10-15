//
//  ShoppingTableViewController.swift
//  SeSAC_SHOPPINGLIST
//
//  Created by 김진영 on 2021/10/14.
//

import UIKit

class ShoppingTableViewController: UITableViewController {

    @IBOutlet weak var ShoppingTableViewTitle: UILabel!
    
//    var list: [String] = UserDefaults.standard.string(forKey: "shopping")! {
//        didSet {
//            print("\(oldValue) -> \(list)")
//        }
//    }
    
    
    var shoppingList: [String] = ["첫번째 목록", "두번째 목록"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UserDefaults.standard.set(shoppingList, forKey: "list")
        
        loadData()
        
    }
    
    func loadData() {
        
        tableView.reloadData()
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
            
            cell.backgroundColor = UIColor(named: "backgroundColor")
            cell.addButton.backgroundColor = .gray
            cell.addButton.setTitle("추가", for: .normal)
            cell.addButton.setTitleColor(.black, for: .normal)
            cell.addButton.backgroundColor = UIColor(named: "buttonColor")
            cell.addButton.layer.cornerRadius = 5
            
            cell.addTextField.backgroundColor = UIColor(named: "backgroundColor")
            cell.addTextField.placeholder = "무엇을 구매하실 건가요?"
            cell.addTextField.borderStyle = .none
            
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "listCell") as? ListTableViewCell else {
                return UITableViewCell()
            }
            
            cell.backgroundColor = UIColor(named: "backgroundColor")
            cell.ListLabel.text = shoppingList[indexPath.row]
            
            cell.leftButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            cell.leftButton.tintColor = .black
            
            cell.rightButton.setImage(UIImage(systemName: "star"), for: .normal)
            cell.rightButton.tintColor = .black

            
            return cell
        }
             
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 60 : 44
    }
    
    //(옵션) 셀 스와이프 On/Off 여부 : canEditRowAt
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 0 ? false : true
    }
    
    //옵션 : 셀 스와이프 기능으로 delete editingStyle
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if indexPath.section == 1 {
            if editingStyle == .delete {
                
                let defaults = UserDefaults.standard
                
                shoppingList = defaults.array(forKey: "list") as? [String] ?? []
                
                shoppingList.remove(at: indexPath.row)
                
                defaults.set(shoppingList, forKey: "list")
                
                tableView.reloadData()
            }
        }
        
    }
    

}
