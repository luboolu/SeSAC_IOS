//
//  LottoViewController.swift
//  CLASS_WEEK14
//
//  Created by 김진영 on 2021/12/28.
//

import UIKit
import SnapKit

class LottoViewController: UIViewController {
    
    let viewModel = LottoViewModel()
    
    //1~7, 일치, 당첨 금액
    let label1 = UILabel()
    let label2 = UILabel()
    let label3 = UILabel()
    let label4 = UILabel()
    let label5 = UILabel()
    let label6 = UILabel()
    let label7 = UILabel()
    
    let dateLabel = UILabel()
    let moneyLabel = UILabel()
    
    let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.backgroundColor = .white
        view.distribution = .fillEqually
        
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.lotto1.bind { number in
            DispatchQueue.main.async {
                self.label1.text = "\(number)"
            }
        }
        
        viewModel.lotto2.bind { number in
            DispatchQueue.main.async {
                self.label2.text = "\(number)"
            }
        }
        
        viewModel.lotto3.bind { number in
            DispatchQueue.main.async {
                self.label3.text = "\(number)"
            }
        }
        
        viewModel.lotto4.bind { number in
            DispatchQueue.main.async {
                self.label4.text = "\(number)"
            }
        }
        
        viewModel.lotto5.bind { number in
            DispatchQueue.main.async {
                self.label5.text = "\(number)"
            }
        }
        
        viewModel.lotto6.bind { number in
            DispatchQueue.main.async {
                self.label6.text = "\(number)"
            }
        }
        
        viewModel.lotto7.bind { number in
            DispatchQueue.main.async {
                self.label7.text = "\(number)"
            }
        }
        
        viewModel.lottoMoney.bind { money in
            self.moneyLabel.text = "\(money)"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.viewModel.fetchLottoAPI(380)
        }
        

        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.height.equalTo(50)
            make.center.equalTo(view)
        }
        
        [label1, label2, label3, label4, label5, label6, label7].forEach {
            $0.backgroundColor = .lightGray
            stackView.addArrangedSubview($0)
        }
        
        view.addSubview(dateLabel)
        dateLabel.backgroundColor = .white
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(20)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.height.equalTo(50)
        }
        
        view.addSubview(moneyLabel)
        moneyLabel.backgroundColor = .white
        moneyLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(20)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.height.equalTo(50)
        }
        
    }
}
