//
//  BeerRecommandViewController.swift
//  SeSAC_BEER
//
//  Created by 김진영 on 2021/12/20.
//

import UIKit
import SnapKit

class BeerRecommandViewController: UIViewController {
    
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInsetAdjustmentBehavior = .never
        
        return scrollView
    }()
    
    let containerView = UIView()
    
    let image: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    let imageContainer = UIView()
    
    let resetButton: UIButton = {
        let resetButton = UIButton()
        resetButton.setImage(UIImage(systemName: "arrow.triangle.2.circlepath"), for: .normal)
        resetButton.clipsToBounds = true
        resetButton.layer.cornerRadius = 10
        resetButton.layer.borderWidth = 5
        resetButton.layer.borderColor = UIColor.orange.cgColor
        
        return resetButton
    }()
    
    let shareButton: UIButton = {
        let shareButton = UIButton()
        shareButton.setTitle("Share BEER", for: .normal)
        shareButton.clipsToBounds = true
        shareButton.layer.cornerRadius = 10
        shareButton.layer.borderWidth = 5
        shareButton.layer.borderColor = UIColor.orange.cgColor
        
        return shareButton
    }()
    
    let bottomView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view.backgroundColor = .purple
        scrollView.backgroundColor = .yellow
        imageContainer.backgroundColor = .white
        bottomView.backgroundColor = .white
        

        containerView.addSubview(imageContainer)
        scrollView.addSubview(image)
        scrollView.addSubview(containerView)
        view.addSubview(scrollView)
        
        bottomView.addSubview(resetButton)
        bottomView.addSubview(shareButton)
        //view.addSubview(bottomView)
        
        //레이아웃
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        
        imageContainer.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(150)
        }
        
        image.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(imageContainer)
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(0)
            make.width.equalTo(view.frame.width)
            make.left.right.top.equalToSuperview()
            make.height.equalTo(1000)
        }
        
//        bottomView.snp.makeConstraints { make in
//            make.edges.equalTo(0)
//            make.width.equalTo(view.frame.width)
//            make.left.right.top.bottom.equalToSuperview()
//            make.height.equalTo(88)
//        }

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
