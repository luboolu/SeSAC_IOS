//
//  SignUpViewController.swift
//  SSAC_NETFLIX
//
//  Created by 김진영 on 2021/09/30.
//

import UIKit

class SignUpViewController: UIViewController {

    //TextField
    @IBOutlet var emailNumTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var nickNameTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var recomandCodeTextField: UITextField!
    //Button
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var addInfoButton: UIButton!
    //Switch
    @IBOutlet var hideTextFieldSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        signUpButton.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapClicked(_ sender: UITapGestureRecognizer) {
        //키보드 내리기!
        view.endEditing(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
