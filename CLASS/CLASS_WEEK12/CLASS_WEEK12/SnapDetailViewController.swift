//
//  SnapDetailViewController.swift
//  CLASS_WEEK12
//
//  Created by 김진영 on 2021/12/14.
//

import UIKit
import SnapKit

class SnapDetailViewController: UIViewController {
    
    let activateButton = MainActivateButton()
    
    let firstSquareView: SquareBoxView = {
        //토스뱅크
        let view = SquareBoxView()
        view.label.text = "토스뱅크"
        view.imageView.image = UIImage(systemName: "trash.fill")
        return view
    }()
    
    let secondSquareView: SquareBoxView = {
        //토스증권
        let view = SquareBoxView()
        view.label.text = "토스증권"
        view.imageView.image = UIImage(systemName: "chart.xyaxis.line")
        return view
    }()
    
    let thirdSquareView: SquareBoxView = {
        //고객센터
        let view = SquareBoxView()

        view.label.text = "고객센터"
        view.imageView.image = UIImage(systemName: "person")
        return view
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    let moneyLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .yellow
        label.text = "23,215원"
        
        return label
    }()
    let descriptionLabel = UILabel()
    
    let redView = UIView()
    let blueView = UIView()
    
    @objc func activateButtonPushClicked() {
        let vc = DetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func activateButtonClicked() {
        let vc = SettingViewController(nibName: "SettingViewController", bundle: nil)
        vc.name = "고래밥"
        present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //StackView
        view.addSubview(stackView)
        stackView.addArrangedSubview(firstSquareView)
        stackView.addArrangedSubview(secondSquareView)
        stackView.addArrangedSubview(thirdSquareView)
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.centerX.equalTo(view)
            $0.width.equalTo(view.snp.width).multipliedBy(0.9/1.0).inset(20)
            $0.height.equalTo(80)
        }
        
        firstSquareView.alpha = 0
        secondSquareView.alpha = 0
        thirdSquareView.alpha = 0
        
        UIView.animate(withDuration: 0.8) {
            self.firstSquareView.alpha = 1
        } completion: { bool in
            UIView.animate(withDuration: 0.8) {
                self.secondSquareView.alpha = 1
            } completion: { bool in
                UIView.animate(withDuration: 0.8) {
                    self.thirdSquareView.alpha = 1
                }
            }
        }
        
        
        
        activateButton.addTarget(self, action: #selector(activateButtonPushClicked), for: .touchUpInside)
        
        view.backgroundColor = .white
        
        [activateButton, moneyLabel, descriptionLabel].forEach {
            view.addSubview($0)
        }
        
//        moneyLabel.backgroundColor = .yellow
//        moneyLabel.text = "13,254원"
        
        moneyLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.centerY.equalTo(view)
            make.width.equalTo(300)
            make.height.equalTo(80)
        }
        
        activateButton.snp.makeConstraints {
            $0.leadingMargin.equalTo(view)
            $0.trailingMargin.equalTo(view)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(view).multipliedBy(0.1)
        }
        
//        redView.backgroundColor = .red
//        redView.snp.makeConstraints { make in
//            //make.edges.equalTo(view)
////            make.top.equalTo(view)
////            make.trailing.equalTo(view)
////            make.leading.equalTo(view)
////            make.bottom.equalTo(view)
//            make.edges.equalToSuperview().inset(100)
//        }
//
//        redView.snp.updateConstraints { make in
//            make.bottom.equalTo(-500)
//        }
//
//
//        redView.addSubview(blueView)
//        blueView.backgroundColor = .blue
//
//        blueView.snp.makeConstraints { make in
//            make.edges.equalToSuperview().offset(50)
//        }
        
        let colorPickerButton = UIColorWell(frame: CGRect(x: UIScreen.main.bounds.width - 100, y: UIScreen.main.bounds.height - 100, width: 100, height: 100))
        view.addSubview(colorPickerButton)
        colorPickerButton.layer.zPosition = 999
    }
    
    
}
