//
//  SubjectViewController.swift
//  CLASS_WEEK15
//
//  Created by 김진영 on 2022/01/04.
//

import UIKit
import RxSwift

class SubjectViewController: UIViewController {
    let label = UILabel()
    let disposeBag = DisposeBag()
    let nickname = PublishSubject<String>()
    
    let array1 = [1,1,1,1,1,1]
    let array2 = [2,2,2,2,2,2]
    let array3 = [3,3,3,3,3,3]
    
    let subject = PublishSubject<[Int]>()
    
    let behavior = BehaviorSubject<[Int]>(value: [0,0,0,0])
    
    let replay = ReplaySubject<[Int]>.create(bufferSize: 3) //buffer size: 메모리에 저장됨
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let random1 = Observable<Int>.create { observer in
            observer.onNext(Int.random(in: 1...100))
            observer.onNext(Int.random(in: 1...100))
            observer.onNext(Int.random(in: 1...100))
            return Disposables.create()
        }
        
        random1
            .subscribe { value in
                print("random1 \(value)")
            }
            .disposed(by: disposeBag)
        
        
        random1
            .subscribe { value in
                print("random2 \(value)")
            }
            .disposed(by: disposeBag)
 
        
        let randomSubject = BehaviorSubject(value: 0)
        randomSubject.onNext(Int.random(in: 1...100))
        
        randomSubject
            .subscribe { value in
                print("random subject - \(value)")
            } onError: { error in
                print(error)
            } onCompleted: {
                print("completed!")
            } onDisposed: {
                print("disposed!")
            }
            .disposed(by: disposeBag)

    }
    
    func replaySubject() {
        replay.onNext(array1)
        replay.onNext(array2)
        replay.onNext(array3) //버퍼 사이즈만큼 미리 가지고 있을 수 있음
        
        replay
            .subscribe { value in
                print("replay subject - \(value)")
            } onError: { error in
                print(error)
            } onCompleted: {
                print("completed!")
            } onDisposed: {
                print("disposed!")
            }
            .disposed(by: disposeBag)

        replay.onNext([2,4,7,5])
    }
    
    func behaviorSubject() {
        behavior.onNext(array1)
        behavior.onNext(array2)
        behavior.onNext(array3) //구독 전에 이벤트가 있을 경우, 가장 마지막에 전달된 값을 초기값 대신에 가지고 있게 된다

        behavior
            .subscribe { value in
                print("behavior subject - \(value)")
            } onError: { error in
                print(error)
            } onCompleted: {
                print("completed!")
            } onDisposed: {
                print("disposed!")
            }
            .disposed(by: disposeBag)
            
        behavior.onNext(array2)
        behavior.onCompleted()
    }
    
    func publishSibject() {
        subject.onNext(array1) //구독 전이라 이벤트 전달 x
        
        subject
            .subscribe { value in
            print("publish subject - \(value)")
        } onError: { error in
            print(error)
        } onCompleted: {
            print("completed!")
        } onDisposed: {
            print("disposed!")
        }.disposed(by: disposeBag)
        
        subject.onNext(array2)

    }
    
    func aboutSubject() {
        setup()
        
        nickname
            .bind(to: label.rx.text) //subscribe vs bind
            .disposed(by: disposeBag)
        
        nickname.onNext("HAHAHA")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.nickname.onNext("sdfwe")
        }
                                      
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
          self.nickname.onNext("wefr23")
        }
    }
    
    func setup() {
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        label.backgroundColor = .white
        label.textAlignment = .center
    }
}
