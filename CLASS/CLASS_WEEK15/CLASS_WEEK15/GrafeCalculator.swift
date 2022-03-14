//
//  GrafeCalculator.swift
//  CLASS_WEEK15
//
//  Created by 김진영 on 2022/01/03.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class GradeCalculator: UIViewController {
    
    
    let mySwitch = UISwitch()
    
    let first = UITextField()
    let second = UITextField()
    let resultLabel = UILabel()
    
    let disposeBag = DisposeBag()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        
        Observable.combineLatest(first.rx.text.orEmpty, second.rx.text.orEmpty) { textValue1, textValue2 -> Double in
            return (((Double(textValue1) ?? 0.0) + (Double(textValue2) ?? 0.0)) / 2)
        }
        .map { $0.description }
        .bind(to: resultLabel.rx.text)
        .disposed(by: disposeBag)
        
        
        Observable.of(false)
            .bind(to: mySwitch.rx.isOn)
            .disposed(by: disposeBag)
        
    }
    
    func setUp() {
        view.addSubview(mySwitch)
        mySwitch.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        view.addSubview(first)
        view.addSubview(second)
        view.addSubview(resultLabel)
        
        first.backgroundColor = .white
        second.backgroundColor = .white
        resultLabel.backgroundColor = .white
        
        first.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.size.equalTo(50)
            make.leading.equalTo(50)
        }
        
        second.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.size.equalTo(50)
            make.leading.equalTo(120)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.size.equalTo(50)
            make.leading.equalTo(200)
        }
    }
}
