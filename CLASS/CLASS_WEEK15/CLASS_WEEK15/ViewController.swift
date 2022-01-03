//
//  ViewController.swift
//  CLASS_WEEK15
//
//  Created by 김진영 on 2022/01/03.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ViewController: UIViewController {
    
    let tableView = UITableView()
    let label = UILabel()
    let disposeBag = DisposeBag()
    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUp()
        
        //bind: ui의 입장에서 subscribe를 구성?
        viewModel.items
        .bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(element) @ row \(row)"
            return cell
        }
        .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self)
            .map({ data in
            "\(data)를 클릭했습니다!!!"
            
            })
            .bind(to: label.rx.text).disposed(by: disposeBag)
    }
    
    
    func setUp() {
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    

}

class ViewModel {
    
    let items = Observable.just([
        "First Item",
        "Second Item",
        "Third Item"
    ])
}

