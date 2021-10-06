//
//  EmotionViewController.swift
//  SSAC_EMOTIONDIARY
//
//  Created by 김진영 on 2021/10/06.
//

import UIKit

class EmotionViewController: UIViewController {
    
    @IBOutlet var emotionLabel11: UILabel!
    @IBOutlet var emotionLabel12: UILabel!
    @IBOutlet var emotionLabel13: UILabel!
    
    @IBOutlet var emotionLabel21: UILabel!
    @IBOutlet var emotionLabel22: UILabel!
    @IBOutlet var emotionLabel23: UILabel!
    
    @IBOutlet var emotionLabel31: UILabel!
    @IBOutlet var emotionLabel32: UILabel!
    @IBOutlet var emotionLabel33: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //userdefaults에 emotion label에 들어갈 값을 저장
        UserDefaults.standard.set("0", forKey: "num11")
        UserDefaults.standard.set("0", forKey: "num12")
        UserDefaults.standard.set("0", forKey: "num13")
        
        UserDefaults.standard.set("0", forKey: "num21")
        UserDefaults.standard.set("0", forKey: "num22")
        UserDefaults.standard.set("0", forKey: "num23")
        
        UserDefaults.standard.set("0", forKey: "num31")
        UserDefaults.standard.set("0", forKey: "num32")
        UserDefaults.standard.set("0", forKey: "num33")
        
        
        //각 emotion Label을 defaul 값으로 초기화
        emotionLabel11.text = String(UserDefaults.standard.integer(forKey: "num11"))
        emotionLabel12.text = String(UserDefaults.standard.integer(forKey: "num12"))
        emotionLabel13.text = String(UserDefaults.standard.integer(forKey: "num13"))
        
        emotionLabel21.text = String(UserDefaults.standard.integer(forKey: "num21"))
        emotionLabel22.text = String(UserDefaults.standard.integer(forKey: "num22"))
        emotionLabel23.text = String(UserDefaults.standard.integer(forKey: "num23"))
        
        emotionLabel31.text = String(UserDefaults.standard.integer(forKey: "num31"))
        emotionLabel32.text = String(UserDefaults.standard.integer(forKey: "num32"))
        emotionLabel33.text = String(UserDefaults.standard.integer(forKey: "num33"))
        
    }
    
    //1.각 감정에 해당하는 버튼이 눌림
    //2.
    @IBAction func emotionButtonClicked11(_ sender: UIButton) {
        let num11 = UserDefaults.standard.integer(forKey: "num11")
        UserDefaults.standard.set("\(num11 + 1)", forKey: "num11")
        emotionLabel11.text = String(UserDefaults.standard.integer(forKey: "num11"))
    }
    
    @IBAction func emotionButtonClicked12(_ sender: UIButton) {
        let num12 = UserDefaults.standard.integer(forKey: "num12")
        UserDefaults.standard.set("\(num12 + 1)", forKey: "num12")
        emotionLabel12.text = String(UserDefaults.standard.integer(forKey: "num12"))
    }
    
    @IBAction func emotionButtonClicked13(_ sender: UIButton) {
        let num13 = UserDefaults.standard.integer(forKey: "num13")
        UserDefaults.standard.set("\(num13 + 1)", forKey: "num13")
        emotionLabel13.text = String(UserDefaults.standard.integer(forKey: "num13"))
    }
    
    @IBAction func emotionButtonClicked21(_ sender: UIButton) {
        let num21 = UserDefaults.standard.integer(forKey: "num21")
        UserDefaults.standard.set("\(num21 + 1)", forKey: "num21")
        emotionLabel21.text = String(UserDefaults.standard.integer(forKey: "num21"))
    }
    
    @IBAction func emotionButtonClicked22(_ sender: UIButton) {
        let num22 = UserDefaults.standard.integer(forKey: "num22")
        UserDefaults.standard.set("\(num22 + 1)", forKey: "num22")
        emotionLabel22.text = String(UserDefaults.standard.integer(forKey: "num22"))
    }
    
    @IBAction func emotionButtonClicked23(_ sender: UIButton) {
        let num23 = UserDefaults.standard.integer(forKey: "num23")
        UserDefaults.standard.set("\(num23 + 1)", forKey: "num23")
        emotionLabel23.text = String(UserDefaults.standard.integer(forKey: "num23"))
    }
    
    @IBAction func emotionButtonClicked31(_ sender: UIButton) {
        let num31 = UserDefaults.standard.integer(forKey: "num31")
        UserDefaults.standard.set("\(num31 + 1)", forKey: "num31")
        emotionLabel31.text = String(UserDefaults.standard.integer(forKey: "num31"))
    }
    
    @IBAction func emotionButtonClicked32(_ sender: UIButton) {
        let num32 = UserDefaults.standard.integer(forKey: "num32")
        UserDefaults.standard.set("\(num32 + 1)", forKey: "num32")
        emotionLabel32.text = String(UserDefaults.standard.integer(forKey: "num32"))
    }
    
    @IBAction func emotionButtonClicked33(_ sender: UIButton) {
        let num33 = UserDefaults.standard.integer(forKey: "num33")
        UserDefaults.standard.set("\(num33 + 1)", forKey: "num33")
        emotionLabel33.text = String(UserDefaults.standard.integer(forKey: "num33"))
    }
    
    


}
