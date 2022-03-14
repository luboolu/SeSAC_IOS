//
//  ReativeViewController.swift
//  CLASS_WEEK15
//
//  Created by 김진영 on 2022/01/05.
//

import UIKit
import RxSwift
import RxRelay

struct SampleData {
    var user: String
    var age: Int
    var rate: Double
}

class ReativeViewModel {
    
    var data = [
        SampleData(user: "Jack", age: 13, rate: 2.2),
        SampleData(user: "Hue", age: 11, rate: 4.4),
        SampleData(user: "Dustin", age: 12, rate: 3.2),
    ]
    
    //var list = PublishSubject<[SampleData]()
    var list = PublishRelay<[SampleData]>()
    
    func fetchData() {
        //list.onNext(data)
        list.accept(data)
    }
    
    func filterData(query: String) {
        let result = query != "" ? data.filter { $0.user.contains(query)} : data
        //list.onNext(result)
        list.accept(result)
    }
}

class ReactiveViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let searchBar = UISearchBar()
    let tableView = UITableView()
    let resetButton = UIButton()
    
    let viewModel = ReativeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        
        //viewmodel data -> tableview
        viewModel.list
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = "\(element.user): \(element.age)세 \(element.rate)"
            }
//            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, element, cell) in
//                cell.textLabel?.text = "\(element.user): \(element.age)세 \(element.rate)"
//            }
            .disposed(by: disposeBag)
        
        resetButton
            .rx.tap
            .subscribe { _ in
                print("click")
                self.viewModel.fetchData()
            }
            .disposed(by: disposeBag)
        
        searchBar
            .rx.text //서치바에서 텍스트가 변경이 될 때 이벤트 발생
            .orEmpty //옵셔널 해제
            .debounce(RxTimeInterval.seconds(1), scheduler: MainScheduler.instance) //입력할떄마다 서버 호출하면 서버 터짐...사용자의 입력이 끝나고 일정 시간 후에 호출할 수 있도록 텀을 주는 것
            .distinctUntilChanged()
            .subscribe { value in
                print(value)
                self.viewModel.filterData(query: value.element ?? "")
            }
    }
    
    func setUp() {
        navigationItem.titleView = searchBar
        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        view.addSubview(resetButton)
        resetButton.backgroundColor = .red
        resetButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    func reativeText() {
        var apple = 1
        var banana = 2
        
        print(apple + banana)
        
        apple = 10
        banana = 20
        
        let a = BehaviorSubject(value: 1)
        let b = BehaviorSubject(value: 2)
        
        Observable.combineLatest(a, b) { $0 + $1 }
        .subscribe {
            print($0)
        }
        .disposed(by: disposeBag)
        
        a.onNext(50)
        b.onNext(10)
    }
}
