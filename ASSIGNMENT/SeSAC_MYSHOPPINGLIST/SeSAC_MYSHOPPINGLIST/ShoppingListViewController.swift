//
//  ShoppingListViewController.swift
//  SeSAC_MYSHOPPINGLIST
//
//  Created by 김진영 on 2021/11/04.
//

import UIKit

class ShoppingListViewController: UIViewController {

    
    @IBOutlet weak var addTextField: UITextField!
    
    @IBOutlet weak var shoppingListTableView: UITableView!
    
    @IBOutlet weak var addView: UIStackView!
    
    var shoppingList = ["사과", "원피스"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        shoppingListTableView.delegate = self
        shoppingListTableView.dataSource = self
        
        addView.clipsToBounds = true
        addView.layer.cornerRadius = 10
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addButtonClicked(_ sender: UIButton) {
        print(#function)
        
        let addText = addTextField.text!
        
        if addText != "" {
            shoppingList.append(addText)
            shoppingListTableView.reloadData()
            
            addTextField.text = ""
        }
        
        
    }
    
    
    
}

extension ShoppingListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell") as? ListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.listLabel.text = shoppingList[indexPath.row]
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if editingStyle == .delete {
                shoppingList.remove(at: indexPath.row)
                print(shoppingList)
                
                shoppingListTableView.reloadData()
            }
        }
    }
    
    
    
    
}
