//
//  ShoppingListViewController.swift
//  SeSAC_MYSHOPPINGLIST
//
//  Created by 김진영 on 2021/11/04.
//

import UIKit

import RealmSwift
import SwiftUI

class ShoppingListViewController: UIViewController {

    
    @IBOutlet weak var addTextField: UITextField!
    @IBOutlet weak var shoppingListTableView: UITableView!
    @IBOutlet weak var addView: UIStackView!
    
    let localRealm = try! Realm()
    
    var shoppingList = ["사과", "원피스"]
    var tasks: Results<UserList>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Realm is loacaed at: ", localRealm.configuration.fileURL!)

        shoppingListTableView.delegate = self
        shoppingListTableView.dataSource = self
        
        addView.clipsToBounds = true
        addView.layer.cornerRadius = 10
        
        tasks = localRealm.objects(UserList.self).sorted(byKeyPath: "favorite", ascending: false)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addButtonClicked(_ sender: UIButton) {
        print(#function)
        
        let addText = addTextField.text!
        
        if addText != "" {
            //shoppingList.append(addText)
            //shoppingListTableView.reloadData()
            
            
            // Add some tasks
            let task = UserList(content: addTextField.text!, favorite: false, check: false)
            
            try! localRealm.write {
                localRealm.add(task)
            }
            
            addTextField.text = ""
            shoppingListTableView.reloadData()
        }
    }
    
    
}

extension ShoppingListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRowAt")
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell") as? ListTableViewCell else {
            return UITableViewCell()
        }
        
        let task = tasks[indexPath.row]
        print("클로져 이전")
        //favorite 버튼 관련
        cell.favorite = { [unowned self] in
            
            try! localRealm.write {
                localRealm.create(UserList.self, value: ["_id" : task._id, "favorite" : !task.favorite], update: .modified)
                tableView.reloadData()
            }

        }
        print("클로져 이후")
        
        if task.favorite {
            cell.starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            cell.starButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
        
        //check 버튼 관련
        cell.check = { [unowned self] in
            try! localRealm.write {
                localRealm.create(UserList.self, value: ["_id": task._id, "check": !task.check], update: .modified)
                tableView.reloadData()
            }
        }
        
        
        if task.check {
            cell.checkButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        } else {
            cell.checkButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        }
        
        
        
        cell.listLabel.text = task.content
        
        return cell

        
 
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if editingStyle == .delete {
//                shoppingList.remove(at: indexPath.row)
//                print(shoppingList)
                try! localRealm.write {
                    localRealm.delete(tasks[indexPath.row])
                }
                shoppingListTableView.reloadData()
            }
        }
    }
    
    
    
    
}
