//
//  BeerRecommandViewController.swift
//  SeSAC_BEER
//
//  Created by 김진영 on 2021/12/20.
//

import UIKit
import SnapKit
import Kingfisher

class BeerRecommandViewController: UIViewController {
    
    var apiService = APIService()
    var beerData: Beer?
    
    var beerName = "맥주 이름"
    var beerTagline = "설명"
    var beerDescription = "설명2"
    
    private var isOversized = false {
        didSet {
            beerInfo.reloadInputViews()
            //beerInfo.isScrollEnabled = isOversized
        }
    }
    
    var beerInfoHeightConstraint: Constraint!
    private let maxHeight: CGFloat = 40
    var isMoreButtonClicked = false
    
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInsetAdjustmentBehavior = .never
        
        return scrollView
    }()
    
    let containerView = UIView()
    
    let image: UIImageView = {
        let imageView = UIImageView()
        
        let url = URL(string: "https://images.punkapi.com/v2/keg.png")
        imageView.kf.setImage(with: url)
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    let imageContainer = UIView()
    
    let beerInfoView: UIView = {
        let beerView = UIView()
        
        beerView.clipsToBounds = true
        beerView.layer.cornerRadius = 10
        beerView.layer.borderWidth = 1
        beerView.layer.borderColor = UIColor.lightGray.cgColor
        beerView.backgroundColor = .white
        beerView.layer.zPosition = 999
        
        return beerView
    }()
    
    let beerTitle1: UILabel = {
        let titleLabel = UILabel()
        
        titleLabel.text = "Mixtape 8"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.numberOfLines = 0
        
        return titleLabel
    }()
    
    let beerTitle2: UILabel = {
        let titleLabel = UILabel()
        
        titleLabel.text = "A Real Bitter Experience."
        titleLabel.textAlignment = .center
        
        return titleLabel
    }()
    
    let beerInfo: UITextView = {
        let beerTextView = UITextView()
        
        beerTextView.isEditable = false
        beerTextView.text = "A light, crisp and bitter IPA brewed with English and American hops. A small batch brewed only"
        beerTextView.textAlignment = .center
        
        return beerTextView
    }()
    
    let moreButton: UIButton = {
        let moreButton = UIButton()
       
        moreButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        moreButton.tintColor = .lightGray
        moreButton.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        moreButton.titleLabel?.textAlignment = .center
        
        return moreButton
    }()
    
    let resetButton: UIButton = {
        let resetButton = UIButton()
        resetButton.setImage(UIImage(systemName: "arrow.triangle.2.circlepath"), for: .normal)
        resetButton.setPreferredSymbolConfiguration(.init(pointSize: 22, weight: .regular, scale: .default), forImageIn: .normal)
        resetButton.clipsToBounds = true
        resetButton.layer.cornerRadius = 10
        resetButton.layer.borderWidth = 3
        resetButton.layer.borderColor = UIColor(named: "main")!.cgColor
        resetButton.tintColor = UIColor(named: "main")
        
        return resetButton
    }()
    
    let shareButton: UIButton = {
        let shareButton = UIButton()
        shareButton.setTitle("Share BEER", for: .normal)
        shareButton.setTitleColor(.black, for: .normal)
        shareButton.setTitleColor(.lightGray, for: .highlighted)
        shareButton.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        shareButton.clipsToBounds = true
        shareButton.layer.cornerRadius = 10
        shareButton.layer.borderWidth = 5
        shareButton.layer.borderColor = UIColor(named: "main")!.cgColor
        shareButton.backgroundColor = UIColor(named: "main")!
        
        return shareButton
    }()
    
    let bottomView = UIView()

    override func viewDidLoad() {
        print(#function)
        super.viewDidLoad()
        
        beerInfo.delegate = self
        
        view.backgroundColor = .white
        scrollView.backgroundColor = .white
        bottomView.backgroundColor = .white
        
        //containerView.backgroundColor = .blue
        

        imageContainer.addSubview(image)
        containerView.addSubview(imageContainer)
        
        beerInfoView.addSubview(beerTitle1)
        beerInfoView.addSubview(beerTitle2)
        beerInfoView.addSubview(beerInfo)
        beerInfoView.addSubview(moreButton)
        containerView.addSubview(beerInfoView)
        //scrollView.addSubview(image)
        scrollView.addSubview(containerView)
        view.addSubview(scrollView)
        
        bottomView.addSubview(resetButton)
        bottomView.addSubview(shareButton)
        view.addSubview(bottomView)
        
        //레이아웃
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0))
        }
        
        imageContainer.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(250)
        }
        
        image.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(imageContainer)
            //make.height.equalTo(250)
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(0)
            make.width.equalTo(view.frame.width)
            make.left.right.top.equalToSuperview()
            make.height.equalTo(2000)
        }
        
        beerInfoView.snp.makeConstraints { make in
//            make.top.equalTo(image.snp.bottom)
//            make.left.right.bottom.equalToSuperview()
//
            make.top.equalTo(imageContainer.snp.bottom).offset(-50)
            make.trailing.equalTo(scrollView.snp.trailing).offset(-30)
            make.leading.equalTo(scrollView.snp.leading).offset(30)
            //make.height.equalTo(200)

        }
        
        beerTitle1.snp.makeConstraints { make in
            make.top.equalTo(beerInfoView.snp.top).offset(20)
            make.leading.equalTo(beerInfoView.snp.leading).offset(20)
            make.trailing.equalTo(beerInfoView.snp.trailing).offset(-20)
            make.height.equalTo(30)
        }
        
        beerTitle2.snp.makeConstraints { make in
            make.top.equalTo(beerTitle1.snp.bottom).offset(4)
            make.leading.equalTo(beerInfoView.snp.leading).offset(20)
            make.trailing.equalTo(beerInfoView.snp.trailing).offset(-20)
            make.height.equalTo(30)
        }
        
        beerInfo.snp.makeConstraints { make in
            make.top.equalTo(beerTitle2.snp.bottom).offset(4)
            make.leading.equalTo(beerInfoView.snp.leading).offset(20)
            make.trailing.equalTo(beerInfoView.snp.trailing).offset(-20)
            //make.height.equalTo(40)
            beerInfoHeightConstraint = make.height.equalTo(40).constraint
            //make.bottom.equalTo(beerInfoView.snp.bottom).offset(-20)
        }
        
        moreButton.snp.makeConstraints { make in
            make.top.equalTo(beerInfo.snp.bottom).offset(4)
            make.leading.equalTo(beerInfoView.snp.leading).offset(20)
            make.trailing.equalTo(beerInfoView.snp.trailing).offset(-20)
            make.bottom.equalTo(beerInfoView.snp.bottom).offset(-8)
            make.height.equalTo(30)
        }
        
        
        //bottomView
        
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.bottom)
            make.leading.equalTo(0)
            make.trailing.equalTo(0)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        resetButton.snp.makeConstraints { make in
            make.top.equalTo(bottomView.snp.top).offset(5)
            make.leading.equalTo(bottomView.snp.leading).offset(20)
            make.bottom.equalTo(bottomView.snp.bottom).offset(-5)
            make.width.equalTo(bottomView.snp.height).multipliedBy(1)
        }
        
        shareButton.snp.makeConstraints { make in
            make.top.equalTo(bottomView.snp.top).offset(5)
            make.leading.equalTo(resetButton.snp.trailing).offset(10)
            make.trailing.equalTo(bottomView.snp.trailing).offset(-20)
            make.bottom.equalTo(bottomView.snp.bottom).offset(-5)
        }
        
        
        //api 통신
        apiService.requestBeer { beer in
            
            
            self.beerData = beer
            
            print(self.beerData![Int.random(in: 0...self.beerData!.count - 1)].name)
            
            let randNum = Int.random(in: 0...self.beerData!.count - 1)
            
            DispatchQueue.main.async {
                self.beerTitle1.text = self.beerData![randNum].name
                self.beerTitle2.text = self.beerData![randNum].tagline
                self.beerInfo.text = self.beerData![randNum].beerDescription
                
                
                let url = URL(string: self.beerData![randNum].imageURL)
                self.image.kf.setImage(with: url)
                
                
                self.view.reloadInputViews()
            }
            

            
        }
        
        //button
        moreButton.addTarget(self, action: #selector(moreButtonClicked), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetButtonClicked), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(shareButtonClicked), for: .touchUpInside)
        


    }
    
    @objc func resetButtonClicked(_ sender: UIButton) {
        print(#function)
        
        self.isMoreButtonClicked = false
        let randNum = Int.random(in: 0...self.beerData!.count - 1)
        
        DispatchQueue.main.async {
            self.beerTitle1.text = self.beerData![randNum].name
            self.beerTitle2.text = self.beerData![randNum].tagline
            self.beerInfo.text = self.beerData![randNum].beerDescription
            
            
            let url = URL(string: self.beerData![randNum].imageURL)
            self.image.kf.setImage(with: url)
            
            self.beerInfoHeightConstraint.deactivate()
            self.beerInfo.snp.makeConstraints { make in
                self.beerInfoHeightConstraint = make.height.equalTo(40).constraint
            }
            
            self.view.reloadInputViews()
        }
    }
    
    @objc func shareButtonClicked(_ sender: UIButton) {
        print(#function)
        
        
    }
    
    @objc func moreButtonClicked(_ sender: UIButton) {
        print(#function)
        
        self.isMoreButtonClicked = !self.isMoreButtonClicked //toggle
        print(self.isMoreButtonClicked)
        print(self.beerInfo.contentSize.height)
        if self.isMoreButtonClicked {
            //true면 버튼 타이틀 지우고 chevron 이미지로 변경
            self.moreButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
            
            if beerInfo.contentSize.height >= maxHeight {
                print("늘려주기!")
                isOversized = true
                
                beerInfoHeightConstraint.deactivate()
                beerInfo.snp.makeConstraints { make in
                    beerInfoHeightConstraint = make.height.equalTo(beerInfo.contentSize.height).constraint
                }
                
            }
        } else {
            //
            self.moreButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            
            beerInfoHeightConstraint.deactivate()
            beerInfo.snp.makeConstraints { make in
                beerInfoHeightConstraint = make.height.equalTo(40).constraint
            }
        }
        
        beerInfo.reloadInputViews()

        
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

extension BeerRecommandViewController: UITextViewDelegate {
    // MARK: - UITextViewDelegate
    func textViewDidChange(_ textView: UITextView) {
        print(#function)

    }
    

}
