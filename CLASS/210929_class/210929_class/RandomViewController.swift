//
//  RandomViewController.swift
//  SSAC_NETFLIX
//
//  Created by 김진영 on 2021/09/29.
//

import UIKit

class RandomViewController: UIViewController {
    
    @IBOutlet weak var randomLable: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    //뷰컨트롤러의 생명주기
    //회면이 사용자에게 보이기 직전에 실행되는 기능: 모서리 둥글게, 그림자 속성 등 스토리보드에서 구현하기 까다로운 UI를 미리 구현할 때 주로 사용
    override func viewDidLoad() {
        super.viewDidLoad()
        
        randomLable.text = "안녕하세요\n반갑습니다"
        randomLable.textAlignment =  .center
        randomLable.backgroundColor = .systemRed
        randomLable.numberOfLines = 2
        randomLable.font = UIFont.boldSystemFont(ofSize: 20)
        randomLable.textColor = UIColor.white
        randomLable.layer.cornerRadius = 10
        randomLable.clipsToBounds = true
        
        checkButton.backgroundColor = UIColor.magenta
        checkButton.setTitle("행운의 숫자를 뽑아보세요", for: .normal)
        checkButton.setTitle("뽑아 뽑아", for: .highlighted)
        checkButton.layer.cornerRadius = 10
        checkButton.setTitleColor(UIColor.white, for: .normal)
        
    }
    
    
    @IBAction func checkButtonClicked(_ sender: UIButton) {
        let number = Int.random(in: 1...100)
        randomLable.text = "행운의 숫자는 \(number)입니다."
    }
}

