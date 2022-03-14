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
    
    let newlyWord: [String: String] = ["윰차": "유모차", "꾸안꾸": "꾸민듯 안꾸민듯", "오저치고": "오늘 저녁에 치킨 고?","스드메": "스튜디오 드레스 메이크업", "싫테": "'싫어요(유튜브 기능) 테러'의 줄임말", "설참": "'설명 참고'의 줄임말", "횰로": "욜로 + 나홀로의 합성어로 본인 중심의 소비와 행복을 우선시하는 것", "가취관": "같은 취향으로 모이되, 가벼운 모임을 선호하는 밀레니엄-Z세대"]
    var searchList: [String] = ["", "", "", ""]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tagButton1.setTitle("", for: .normal)
        tagButton2.setTitle("", for: .normal)
        tagButton3.setTitle("", for: .normal)
        tagButton4.setTitle("", for: .normal)
        

        
        //text field의 글자가 모두 보이는지 확인하고, 보이지 않는다면 글자의 크기를 조정하여 모두 보이게 함
        if resultLabel.adjustsFontSizeToFitWidth == false {
            resultLabel.adjustsFontSizeToFitWidth = true
        }
        

    }
    
    //Search Button이 눌리면
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        //사전에 있는 단어라면 resultLabel에 뜻을 보여주고, 없다면 지정된 문구를 보여줌
        if searchTextField.text != nil{
            if newlyWord[searchTextField.text!] != nil {
                resultLabel.text = newlyWord[searchTextField.text!]!
                searchList.insert(searchTextField.text!, at: 0)
            } else {
                searchList.insert(searchTextField.text!, at: 0)
                resultLabel.text = "신조어를 찾을 수 없습니다 ㅜㅜ"
            }
            
            updateSearchList()
        } else{
            resultLabel.text = "신조어를 찾을 수 없습니다 ㅜㅜ"
        }
    }
    
    
    @IBAction func tagButton1Clicked(_ sender: UIButton) {
        
    }
    
    @IBAction func tagButton2Clicked(_ sender: UIButton) {
    }
    
    @IBAction func tagButton3Clicked(_ sender: UIButton) {
    }
    
    @IBAction func tagButton4Clicked(_ sender: UIButton) {
    }
    
    func searchNewlyWord(){
        
    }
    
    func updateSearchList(){
        if searchList.count >= 4{
            searchList.remove(at: 4)
        }
        
        tagButton1.setTitle(searchList[0], for: .normal)
        tagButton2.setTitle(searchList[1], for: .normal)
        tagButton3.setTitle(searchList[2], for: .normal)
        tagButton4.setTitle(searchList[3], for: .normal)
        
        if tagButton1.titleLabel!.adjustsFontSizeToFitWidth == false {
            tagButton1.titleLabel!.adjustsFontSizeToFitWidth = true
        }

    }
    
    
    @IBAction func tapGestureRecognizer(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}
