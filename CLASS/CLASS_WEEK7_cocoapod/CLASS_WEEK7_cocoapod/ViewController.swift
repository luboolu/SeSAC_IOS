//
//  ViewController.swift
//  CLASS_WEEK7_cocoapod
//
//  Created by 김진영 on 2021/11/10.
//

import UIKit

class ViewController: UIViewController , PassDataaDelegate {
    //프로토콜의 메서드 사용
    func sendTextData(text: String) {
        textView.text = text
    }
    
    @IBOutlet weak var textView: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(firstNotification(notification:)), name: .myNotification, object: nil)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //옵져버를 여기서 등록해두면...화면전환을 할때마다 옵져버가 늘어난다!
        
    }
    
    //viewAillAppear에서 등록해주면 viewDidLoad, deinit에서 옵져버를 해제해주어야 한다!
    override func viewDidDisappear(_ animated: Bool) {
        print(#function)
    }
    
    deinit {
        //NotificationCenter.default.removeObserver(self, name: NSNotification.Name("firstNotification"), object: nil)
    }
    
    @objc func firstNotification(notification: NSNotification) {
        print("NOTIFICATION!")
        
        
        if let text = notification.userInfo?["myText"] as? String {
            textView.text = text
        }
    }

    @IBAction func buttonClicked(_ sender: UIButton) {
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "YellowViewController") as? YellowViewController else { return }
        
        vc.buttonActionHandler = {
            
            print("buttonActionHandler")
            self.textView.text = vc.textView.text
        }
        
        
        vc.textSpace = textView.text
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func notificationButtonClicked(_ sender: UIButton) {
        
        //NotificationCenter.default.post(name: NSNotification.Name("firstNotification"), object: nil, userInfo: ["myText": textView.text!, "value": 123])
        
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "YellowViewController") as? YellowViewController else { return }
        
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func protocolButtonClicked(_ sender: UIButton) {
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "YellowViewController") as? YellowViewController else { return }
        
        vc.delegate = self
        
        self.present(vc, animated: true, completion: nil)
        
        
    }
    
}


extension NSNotification.Name {
    static let myNotification = NSNotification.Name("firstNotification")
}
