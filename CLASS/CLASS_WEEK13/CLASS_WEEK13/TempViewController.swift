//
//  TempViewController.swift
//  CLASS_WEEK13
//
//  Created by 김진영 on 2021/12/24.
//

import UIKit

class TempViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        
        var country = "stroyboard"
        // Do any additional setup after loading the view.
    }
    //MARK: TableView
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(#function)
    }
 
}

class User {

    var naem: String
    var age: Int
    var eamil: String
    var review: Double
    
    internal init(naem: String, age: Int, eamil: String, review: Double) {
        self.naem = naem
        self.age = age
        self.eamil = eamil
        self.review = review
    }
    
    
    
}
