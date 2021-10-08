//
//  ProfileViewController.swift
//  SeSSAC_WATER
//
//  Created by 김진영 on 2021/10/08.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet var nickNameTextField: UITextField!
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    


    @IBAction func saveButtonClicked(_ sender: UIBarButtonItem) {
        
        UserDefaults.standard.set(nickNameTextField.text, forKey: "nickName")
        UserDefaults.standard.set(heightTextField.text, forKey: "height")
        UserDefaults.standard.set(weightTextField.text, forKey: "weight")
        
        let nickName = UserDefaults.standard.string(forKey: "nickName")
        let height = UserDefaults.standard.integer(forKey: "height")
        let weight = UserDefaults.standard.integer(forKey: "weight")
        
        print("\(nickName)님은 \(height)cm이고 \(weight)kg입니다.")
        
        
    }
    
}
