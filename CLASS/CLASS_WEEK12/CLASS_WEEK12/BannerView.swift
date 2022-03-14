//
//  BannerView.swift
//  CLASS_WEEK12
//
//  Created by 김진영 on 2021/12/13.
//

import UIKit

class BannerView: UIView {
    
    let mainLabel = UILabel()
    let descriptionLabel = UILabel()
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        loadLayout()
    }
    
    //?붙어있으므로 실패 가능한 이니셜라이져
    //스토리보드에서 등록된 뷰는 내부적으로 NSCoder가 실행되므로 자동적으로 required init으로 넘어간다
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadLayout() {
        mainLabel.font = .boldSystemFont(ofSize: 15)
        mainLabel.textColor = .black
        mainLabel.text = "내일 오를 주식을 맞춰주세요!"
        
        descriptionLabel.font = .boldSystemFont(ofSize: 12)
        descriptionLabel.textColor = .darkGray
        descriptionLabel.text = "맞히면 500원 드려요"
        
        mainLabel.frame = CGRect(x: 30, y: 30, width: UIScreen.main.bounds.width - 130, height: 40)
        descriptionLabel.frame = CGRect(x: 30, y: 80, width: UIScreen.main.bounds.width - 130, height: 30)
        
        self.addSubview(mainLabel)
        self.addSubview(descriptionLabel)
        
    }
    
    
}
