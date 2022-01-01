//
//  StartViewController.swift
//  SeSAC_FARM
//
//  Created by 김진영 on 2022/01/01.
//

import UIKit
import SnapKit

class StartViewController: UIViewController {
    
    var sesacImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "logo_ssac_clear")
        
        return imageView
    }()
    
    var commentLabel1: UILabel = {
        let label = UILabel()
        
        label.text = "당신 근처의 새싹농장"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        
        return label
    }()
    
    var commentLabel2: UILabel = {
        let label = UILabel()
        
        label.text = "iOS 지식부터 바람의 나라까지 \n 지금 SeSAC에서 함께해보세요!"
        label.textColor = .black
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .center
        
        return label
    }()
    
    var startButton: UIButton = {
       let button = UIButton()
        
        button.setTitle("시작하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(named: "sesac_green")
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    var loginButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(UIColor(named: "sesac_green"), for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = .systemFont(ofSize: 13)
        
        return button
    }()
    
    var loginGuideLabel: UILabel = {
        let label = UILabel()
        
        label.text = "이미 계정이 있나요?"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 13)
        
        return label
    }()
    
    var guideStackView: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.backgroundColor = .clear
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        
        return stack

    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        //self.navigationController?.navigationBar.topItem?.title = ""
        
        settingUI()
        
        startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
    }
    
    @objc func startButtonClicked() {
        let vc = SignUpViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func settingUI() {
        
        view.addSubview(sesacImageView)
        view.addSubview(commentLabel1)
        view.addSubview(commentLabel2)
        view.addSubview(startButton)

        guideStackView.addArrangedSubview(loginGuideLabel)
        guideStackView.addArrangedSubview(loginButton)
        
        view.addSubview(guideStackView)
        
        sesacImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(200)
        }
        
        commentLabel1.snp.makeConstraints { make in
            make.top.equalTo(sesacImageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
            
        }
        
        commentLabel2.snp.makeConstraints { make in
            make.top.equalTo(commentLabel1.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(50)
            make.trailing.equalToSuperview().offset(-50)
        }


        startButton.snp.makeConstraints { make in
            make.bottom.equalTo(guideStackView.snp.top).offset(-10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(66)
        }
        
        guideStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.centerX.equalToSuperview()
        }
        
        
    }
    
    
    
}
