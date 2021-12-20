//
//  DetailViewController.swift
//  CLASS_WEEK12
//
//  Created by 김진영 on 2021/12/13.
//

import UIKit
import FirebaseInstallations

class DetailViewController: UIViewController {
    
    let bannerView = BannerView()
    let titleLabel = UILabel()
    let captionLabel = UILabel()
    let activateButton = MainActivateButton()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        //12.14 수업
        //bannerView.frame = CGRect(x: 30, y: 100, width: UIScreen.main.bounds.width - 60,  height: 120)
        //view.addSubview(bannerView)
        
        [titleLabel, captionLabel, activateButton].forEach { hello in
            hello.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(hello)
        }
        
        
        setTitleLabelConstraints()
        setCaptionLabelConstraints()
        setActivateButtonConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Installations.installations().delete { error in
          if let error = error {
            print("Error deleting installation: \(error)")
            return
          }
          print("Installation deleted");
        }
    }
    
    func setActivateButtonConstraints() {
        //view.addSubview(activateButton)
        //activateButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activateButton.widthAnchor.constraint(equalToConstant: 300),
            activateButton.heightAnchor.constraint(equalToConstant: 50),
            activateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        

        
        
        
        
        
    }
    
    func setTitleLabelConstraints() {
        
        titleLabel.text = "관심 있는 회사\n3개를 선택해주세요"
        titleLabel.backgroundColor = .lightGray
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        //view.addSubview(titleLabel)
        
        //titleLabel.frame = CGRect(x: 100, y: 100, width: UIScreen.main.bounds.width - 200, height: 80)
        
        //titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //NSLayouyConstraint
        let topConstraint = NSLayoutConstraint(item: titleLabel, attribute: .top , relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 0)
        topConstraint.isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 40).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -40).isActive = true
        NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 80).isActive = true

        
    }
    
    func setCaptionLabelConstraints() {
        captionLabel.text = "맞춤 정보를 알려드려요"
        captionLabel.backgroundColor = .darkGray
        captionLabel.font = .boldSystemFont(ofSize: 12)
        captionLabel.textAlignment = .center
        
        //view.addSubview(captionLabel)
        //captionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraints = NSLayoutConstraint(item: captionLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 0)
        let centerX = NSLayoutConstraint(item: captionLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: captionLabel, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.7, constant: 0)
        let height = NSLayoutConstraint(item: captionLabel, attribute: .height, relatedBy: .equal, toItem: titleLabel, attribute: .height, multiplier: 0.5, constant: 0)
        
        view.addConstraints([topConstraints, centerX, width, height])
    }

}
