//
//  ButtonViewController.swift
//  CLASS_WEEK15
//
//  Created by 김진영 on 2022/01/06.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ButtonViewModel {
    
    var disposeBag: DisposeBag = DisposeBag()
    
    struct Input {
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let text: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        let result = input.tap
            .map { "안녕 반가웡><"}
            .asDriver(onErrorJustReturn: "")
        
        return Output(text: result)
    }
    
}

class ButtonViewController: UIViewController {
    
    let button = UIButton()
    let label = UILabel()
    
    let disposeBag = DisposeBag()
    let viewModel = ButtonViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        
        
//  아래 4개 모두 같은 동작을 하는 코드...!
//        button
//            .rx.tap
//            .observe(on: MainScheduler.instance) //그렇기 때문에 메인 스레드에서 동작할 것을 명시해준다.
//            .subscribe { value in
//                print("clicked!")
//                self.label.text = "안녕 반가워" //subscribe의 경우 background thread로 돌아갈수도 있다. 항상 메인 스레드인게 아니다.
//            }
//            .disposed(by: disposeBag)
        
        //or
//        button.rx.tap
//            .bind(to: { _ in
//                self.label.text = "안녕 반가워@!!"
//            })
//            .disposed(by: disposeBag)
        
//        button.rx.tap
//            .map { "안녕 반가워" }
//            .bind(to: label.rx.text)
//            .disposed(by: disposeBag)
        
//        button.rx.tap
//            .map { "안녕 반가워" }
//            .asDriver(onErrorJustReturn: "")
//            .drive(label.rx.text)
//            .disposed(by: disposeBag)
        
        let input = ButtonViewModel.Input(tap: button.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.text
            .drive(label.rx.text)
            .disposed(by: disposeBag)

    }
    
    @objc func buttonClicked() {
        
    }
    
    func setUp() {
        view.addSubview(button)
        view.addSubview(label)
        
        button.backgroundColor = .white
        label.backgroundColor = .lightGray
        
        button.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.center.equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.leading.equalTo(20)
            make.width.equalTo(300)
            make.height.equalTo(50)
            
        }
    }
}
