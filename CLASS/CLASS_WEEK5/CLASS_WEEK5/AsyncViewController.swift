//
//  AsyncViewController.swift
//  CLASS_WEEK5
//
//  Created by 김진영 on 2021/10/29.
//

import UIKit

class AsyncViewController: UIViewController {

        
    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet var outletLabel: [UILabel]!
    
    let url = "https://images.unsplash.com/photo-1555234432-e681ac3ad0ab?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1474&q=80"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //1. 어제 날짜 구하기
        let calendar = Calendar.current
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: Date())
        print(tomorrow)
        
        //2. 이번주 월요일은?
        var component = calendar.dateComponents([.weekOfYear, .yearForWeekOfYear, .weekday], from: Date())
        component.weekday = 2 //6번 금요일
        let mondayWeek = calendar.date(from: component)
        print(mondayWeek)
        
        
        for i in outletLabel {
            i.backgroundColor = .blue
        }
        //for문으로 outlet collection의 ui를 설정해줄수도 있고, forEach를 사용해 설정해줄수도 있다.
        outletLabel.forEach {
            $0.backgroundColor = .red
            $0.clipsToBounds = true
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.black.cgColor
        }
        
       
    }
    

    @IBAction func requestButtonClicked(_ sender: UIButton) {
        
        DispatchQueue.global().async {
            if let url = URL(string: self.url), let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                
                
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
        

        
    }
    
}
