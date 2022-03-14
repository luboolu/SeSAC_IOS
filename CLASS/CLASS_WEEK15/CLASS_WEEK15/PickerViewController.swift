//
//  PickerViewController.swift
//  CLASS_WEEK15
//
//  Created by 김진영 on 2022/01/03.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class PickerViewController: UIViewController {
    let pickerView = UIPickerView()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        
        let items = Observable.just([
                "영화",
                "드라마",
                "애니메이션"
            ])
     
        items
            .bind(to: pickerView.rx.itemTitles) { (row, element) in
                return element
            }
            .disposed(by: disposeBag)
        
        pickerView.rx.modelSelected(String.self).subscribe { value in
            print("PICKER SELECT: \(value)")
        }.disposed(by: disposeBag)
     
    }
    
    func setUp() {
        view.addSubview(pickerView)
        pickerView.backgroundColor = .white
        pickerView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
    }
}
