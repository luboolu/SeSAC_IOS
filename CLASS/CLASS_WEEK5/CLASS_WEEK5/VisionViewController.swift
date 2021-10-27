//
//  VisionViewController.swift
//  CLASS_WEEK5
//
//  Created by 김진영 on 2021/10/27.
//

import UIKit

class VisionViewController: UIViewController {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func requestButtonClicked(_ sender: UIButton) {
        print(#function)
        VisionAPIManager.shared.fecthFaceData(image: postImageView.image!) { code, json in
            print(json)
        }
        
    }
}
