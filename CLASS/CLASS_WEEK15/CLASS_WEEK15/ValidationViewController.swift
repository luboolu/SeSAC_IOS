//
//  ValidationViewController.swift
//  CLASS_WEEK15
//
//  Created by 김진영 on 2022/01/05.
//

import UIKit
import RxSwift
import RxCocoa


protocol CommonViewModel {
    
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}


class ValidationViewModel: CommonViewModel {
    
    struct Input {
        let text: ControlProperty<String?>
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let validStatus: Observable<Bool>
        let validText: BehaviorRelay<String>
        let sceneTransition: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        let resultText = input.text
            .orEmpty
            .map{ $0.count >= 5 }
            .share(replay: 1, scope: .whileConnected)
        
        return Output(validStatus: resultText, validText: validText, sceneTransition: input.tap)
    }
    
    var validText = BehaviorRelay<String>(value: "최소 8자 이상 필요해요")
}

class ValidationViewController: UIViewController {
    
    let nameValidationLabel = UILabel()
    let nameTextField = UITextField()
    let button = UIButton()
    
    let viewModel = ValidationViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        viewModel.validText
//            .asDriver()
//            .drive(nameValidationLabel.rx.text)
//            .disposed(by: disposeBag)
//
//        let validation = nameTextField
//            .rx.text
//            .orEmpty
//            .map { $0.count >= 0}
//            .share(replay: 1, scope: .whileConnected)
//
//        validation
//            .bind(to: button.rx.isEnabled)
//            .disposed(by: disposeBag)
//
//        validation
//            .bind(to: nameValidationLabel.rx.isHidden)
//            .disposed(by: disposeBag)
//
//        button.rx.tap
//            .subscribe { _ in
//                self.present(ReactiveViewController(), animated: true, completion: nil)
//            }
//            .disposed(by: disposeBag)

        
        setUp()
        bind()
    }
    
    func bind() {
        let input = ValidationViewModel.Input(text: nameTextField.rx.text, tap: button.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.validStatus
            .bind(to: button.rx.isEnabled)
            .disposed(by: disposeBag)
        
        output.validText
            .asDriver()
            .drive(nameValidationLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.sceneTransition
            .subscribe { _ in
                self.present(ReactiveViewController(), animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
        
    }
    
    func setUp() {
//        [nameTextField, button, nameValidationLabel].forEach {
//            $0.backgroundColor = .white
//            view.addSubview($0)
//        }
        
        nameTextField.backgroundColor = .white
        view.addSubview(nameTextField)
        
        button.backgroundColor = .white
        view.addSubview(button)
        
        nameValidationLabel.backgroundColor = .white
        view.addSubview(nameValidationLabel)
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        
        nameValidationLabel.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        
        button.snp.makeConstraints { make in
            make.top.equalTo(nameValidationLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        

    }
}
