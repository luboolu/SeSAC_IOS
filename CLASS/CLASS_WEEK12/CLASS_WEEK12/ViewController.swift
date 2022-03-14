//
//  ViewController.swift
//  CLASS_WEEK12
//
//  Created by 김진영 on 2021/12/13.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var favoriteMenuView: SquareBoxView!
    
    let redView = UIView()
    let greenView = UIView()
    let blueView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        blueView.addSubview(redView)
        view.addSubview(greenView)
        view.addSubview(blueView)
        
        blueView.clipsToBounds = true
        blueView.alpha = 0.5
        
        redView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        greenView.frame = CGRect(x: 100, y: 100, width: 150, height: 150)
        blueView.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        
        redView.backgroundColor = .red
        greenView.backgroundColor = .green
        blueView.backgroundColor = .blue
        
        favoriteMenuView.label.text = "즐겨찾기"
        favoriteMenuView.imageView.image = UIImage(systemName: "star")
    }
    
    @IBAction func presentButtonClicked(_ sender: UIButton) {
        //따로 스토리보드 파일이 없으므로 바로 뷰컨트롤러를 띄우면 됨
        self.present(DetailViewController(), animated: true, completion: nil)
    }
    

}

