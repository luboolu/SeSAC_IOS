//
//  YellowViewController.swift
//  CLASS_WEEK7_cocoapod
//
//  Created by 김진영 on 2021/11/10.
//

import UIKit

protocol PassDataaDelegate {
    func sendTextData(text: String)
}


class YellowViewController: UIViewController {
    
    
    var textSpace: String = ""
    
    var buttonActionHandler: (() -> ())?
    
    var delegate: PassDataaDelegate?
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        textView.text = textSpace
        
        
        //NotificationCenter.default.addObserver(self, selector: #selector(firstNotification), name: NSNotification.Name("firstNotification"), object: nil)
        // Do any additional setup after loading the view.
    }
    
//    @objc func firstNotification(notification: NSNotification) {
//        print("NOTIFICATION!")
//    }
    
 
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        buttonActionHandler?()
        
        guard let presentVC = self.presentingViewController else { return }
        
        self.dismiss(animated: true) {
            print("화면이 닫혔습니다.")
            
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "PopUpViewController") as? PopUpViewController else { return }
            
            presentVC.present(vc, animated: true, completion: nil)
            
            
        }
        
    }
    
    
    @IBAction func notificationButtonClicked(_ sender: UIButton) {
        
        NotificationCenter.default.post(name: NSNotification.Name("firstNotification"), object: nil, userInfo: ["myText": textView.text!, "value": 123])
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func protocolButtonClicked(_ sender: UIButton) {
        
        if let text = textView.text {
            delegate?.sendTextData(text: text)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
