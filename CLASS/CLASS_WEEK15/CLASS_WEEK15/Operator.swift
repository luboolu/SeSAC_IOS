//
//  Operator.swift
//  CLASS_WEEK15
//
//  Created by 김진영 on 2022/01/03.
//

import UIKit
import RxSwift

enum ExampleError: Error {
    case fail
}

class Operator: UIViewController {
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Observavle: 주어진 상황에 대해서 전달함
        //create > subscribe > next > complete or error ( > dispose )
        //dispose: 내부적으로 메모리를 관리. 뷰컨트롤러가 deinit 될때 호출됨
        
        Observable.from(["가", "나", "다"])
            .subscribe { value in
                print("next: \(value)")
            } onError: { error in
                print(error)
            } onCompleted: {
                print("complete")
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposeBag)
        
        Observable<Int>.interval(.seconds(2), scheduler: MainScheduler.instance)
            .subscribe { value in
                print("next: \(value)")
            } onError: { error in
                print(error)
            } onCompleted: {
                print("complete")
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposeBag)
        
        Observable.repeatElement("JACK")
            .subscribe { value in
                print("next: \(value)")
            } onError: { error in
                print(error)
            } onCompleted: {
                print("complete")
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposeBag)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.disposeBag = DisposeBag()
            //self.dismiss(animated: true, completion: nil)
            
        }

        
    }
    
    deinit {
        print("Operator Deinit!")
    }
    
    //1.3일 어제 수업
    func basic () {
        let items = [3.3, 4.0, 5.0, 3.6, 4.8]
        
        Observable.just(items)
            .subscribe { value in
                print(value)
            }
            .disposed(by: disposeBag)
        
        Observable.of(items)
            .subscribe { value in
                print("of - \(value)")
            }
            .disposed(by: disposeBag)
        
        Observable.from(items)
            .subscribe { value in
                print("from - \(value)")
            }
            .disposed(by: disposeBag)
        
        Observable<Double>.create { observer -> Disposable in
            
            for i in items {
                if i < 3.0 {
                    observer.onError(ExampleError.fail)
                    break
                }
                observer.onNext(i)
            }
            
            observer.onCompleted()
            
            return Disposables.create()
            
        }.subscribe { value in
            print(value)
        } onError: { error in
            print(error)
        } onCompleted: {
            print("completed!!")
        } onDisposed: {
            print("disposed!")
        }
        .disposed(by: disposeBag)

    }
}
