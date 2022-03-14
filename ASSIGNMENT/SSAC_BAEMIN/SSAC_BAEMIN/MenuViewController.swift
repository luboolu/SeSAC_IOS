//
//  MenuViewController.swift
//  SSAC_BAEMIN
//
//  Created by 김진영 on 2021/10/01.
//

import UIKit

class MenuViewController: UIViewController {
    
    let menu: Dictionary<String,String> = ["패스트푸드": "mono_baedal"]
    var menuImage: UIImage?

    
    @IBOutlet var menuButton11: UIButton!
    @IBOutlet var menuButton12: UIButton!
    @IBOutlet var menuButton13: UIButton!
    @IBOutlet var menuButton14: UIButton!
    
    @IBOutlet var menuButton21: UIButton!
    @IBOutlet var menuButton22: UIButton!
    @IBOutlet var menuButton23: UIButton!
    @IBOutlet var menuButton24: UIButton!
    
    @IBOutlet var menuButton31: UIButton!
    @IBOutlet var menuButton32: UIButton!
    @IBOutlet var menuButton33: UIButton!
    @IBOutlet var menuButton34: UIButton!
    
    @IBOutlet var menuButton41: UIButton!
    @IBOutlet var menuButton42: UIButton!
    @IBOutlet var menuButton43: UIButton!
    @IBOutlet var menuButton44: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //menuImage = UIImage(named: "mono_baedal16")
//        menuButton11.setImage(UIImage(named: "mono_baedal16"), for: .normal)
//
//
//        menuButton11.setTitle("패스트푸드", for: .normal)
//        menuButton11.setTitleColor(.black, for: .normal)
//
//        menuButton12.setImage(UIImage(named: "mono_baedal01"), for: .normal)
//        menuButton12.setTitle("배민라이더스", for: .normal)
//        menuButton12.setTitleColor(.black, for: .normal)
//
//        menuButton13.setImage(UIImage(named: "mono_baedal02"), for: .normal)
//        menuButton13.setTitle("1인분", for: .normal)
//        menuButton13.setTitleColor(.black, for: .normal)
//
//        menuButton14.setImage(UIImage(named: "mono_baedal03"), for: .normal)
//        menuButton14.setTitle("배민오더", for: .normal)
//        menuButton14.setTitleColor(.black, for: .normal)
        
        //menuButtonSetting(menuButton: menuButton11, menuName: "패스트푸드")
        // Do any additional setup after loading the view.
    }
    
    func menuButtonSetting (menuButton: UIButton, menuName: String){
        
//        menuImage = UIImage(named: "mono_baedal16")
//        menuButton.setImage(menuImage, for: .normal)
//        menuButton.setTitle(menuName, for: .normal)

    }

}
