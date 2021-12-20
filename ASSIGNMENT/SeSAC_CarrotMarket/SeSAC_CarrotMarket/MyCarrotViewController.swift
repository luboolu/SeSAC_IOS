//
//  MyCarrotViewController.swift
//  SeSAC_CarrotMarket
//
//  Created by 김진영 on 2021/12/15.
//

import UIKit

class MyCarrotViewController: UIViewController {
    
    let carrotProfileTableView = UITableView()
    let carrotMenuTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        
    }
    
    func navigationBarSetting() {
        //self.navigationController?.navigationBar.topItem?.title = "홈"
        let locationButton = UIBarButtonItem(title: "신정동", style: .plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItem = locationButton
        
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: nil)
        let menuButton = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .plain, target: self, action: nil)
        let alertButton = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: nil)
        
        self.navigationItem.rightBarButtonItems = [searchButton, menuButton, alertButton]
        self.navigationController?.navigationBar.tintColor = .black
        
    }
    
    func tableViewSetting() {
        carrotMenuTableView.delegate = self
        carrotMenuTableView.dataSource = self
        
        carrotMenuTableView.delegate = self
        carrotMenuTableView.dataSource = self
        
//        let nibName = UINib(nibName: "HomeTableViewCell", bundle: nil)
//        carrotTableView.register(nibName, forCellReuseIdentifier: "HomeTableViewCell")
        
        view.addSubview(carrotMenuTableView)
        
        carrotMenuTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension MyCarrotViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
