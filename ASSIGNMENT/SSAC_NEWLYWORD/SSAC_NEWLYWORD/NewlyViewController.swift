//
//  NewlyViewController.swift
//  SSAC_NEWLYWORD
//
//  Created by 김진영 on 2021/10/05.
//

import UIKit

class NewlyViewController: UIViewController {
    
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    
    
    @IBOutlet var tagButton1: UIButton!
    @IBOutlet var tagButton2: UIButton!
    @IBOutlet var tagButton3: UIButton!
    @IBOutlet var tagButton4: UIButton!
    
    
    @IBOutlet var resultLabel: UILabel!
    
    let newlyWord: [String: String] = ["윰차": "유모차", "꾸안꾸": "꾸민듯 안꾸민듯", "오저치고": "오늘 저녁에 치킨 고?"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagButton1.setTitle("윰차으아아아아아악", for: .normal)
        tagButton2.setTitle("실매", for: .normal)
        tagButton3.setTitle("만반잘부", for: .normal)
        tagButton4.setTitle("꾸안꾸", for: .normal)
        
        tagButton1.titleLabel?.numberOfLines = 0
        tagButton2.titleLabel?.numberOfLines = 0
        tagButton3.titleLabel?.numberOfLines = 0
        tagButton4.titleLabel?.numberOfLines = 0
        
        tagButton1.titleLabel?.adjustsFontSizeToFitWidth = true
        tagButton2.titleLabel?.adjustsFontSizeToFitWidth = true
        tagButton3.titleLabel?.adjustsFontSizeToFitWidth = true
        tagButton4.titleLabel?.adjustsFontSizeToFitWidth = true
        
        //text field의 글자가 모두 보이는지 확인하고, 보이지 않는다면 글자의 크기를 조정하여 모두 보이게 함
        if resultLabel.adjustsFontSizeToFitWidth == false {
            resultLabel.adjustsFontSizeToFitWidth = true
        }
        

    }
    
    //Search Button이 눌리면
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        //사전에 있는 단어라면 resultLabel에 뜻을 보여주고, 없다면 지정된 문구를 보여줌
        if searchTextField.text != nil && newlyWord[searchTextField.text!] != nil{
            resultLabel.text = newlyWord[searchTextField.text!]!
        } else{
            resultLabel.text = "사전에 없는 단어에요ㅜㅜ"
        }
        
        
    }
    
    


}
