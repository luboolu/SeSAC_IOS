//
//  NetworkViewController.swift
//  CLASS_WEEK15
//
//  Created by 김진영 on 2022/01/04.
//

import Foundation
import UIKit
import RxSwift
import RxAlamofire

class NetworkViewcontroller: UIViewController {
    
    let urlString = "https://aztro.sameerkumar.website/?sign=aries&day=today"
    let lottoURL = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=861"
    
    let disposeBag = DisposeBag()
    
    let label = UILabel()
    let number = BehaviorSubject<String>(value: "오늘의 운세")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        
        number
            .bind(to: label.rx.text)
//            .subscribe { value in
//                self.label.text = value
//            }
            .disposed(by: disposeBag)

        useURLSession(url: lottoURL)
            .decode(type: Lotto.self, decoder: JSONDecoder())
            .subscribe { value in
                self.number.onNext(value.drwNoDate)
            }
            .disposed(by: disposeBag)
        
        let request = useURLSession(url: lottoURL).decode(type: Lotto.self, decoder: JSONDecoder())
        
        request
            .subscribe { value in
                print("value1")
                print(value)
            }
            .disposed(by: disposeBag)
        
        request
            .subscribe { value in
                print("value2")
                print(value)
            }
            .disposed(by: disposeBag)
    }
    
    func setUp() {
        view.addSubview(label)
        label.backgroundColor = .white
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    func useURLSession(url: String) -> Observable<Data> {
        return Observable.create { value in
            let url = URL(string: self.lottoURL)!
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard error == nil else {
                    value.onError(ExampleError.fail)
                    return
                }
                
                if let data = data {
                    value.onNext(data)
                }
                
                value.onCompleted()
            }
            
            task.resume()
            
            return Disposables.create() {
                task.cancel()
            }
        }
    }
    
    func rxAlamofire() {
        number
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        
        json(.get, lottoURL)
            .subscribe { value in
                print(value)
            } onError: { error in
                print(error)
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("dispose")
            }
            .disposed(by: disposeBag)

        json(.post, urlString) //parameters: ["a": "gdsr", "wasr": "Wegfa]
            .subscribe { value in
                print(value)
                guard let data = value as? [String: Any] else { return }
                guard let result = data["lucky_number"] as? String else { return }
                print("==\(result)")
                self.number.onNext(result)
            } onError: { error in
                print(error)
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("dispose")
            }
            .disposed(by: disposeBag)

    }
}
