//
//  HomeViewController.swift
//  SeSAC_CarrotMarket
//
//  Created by 김진영 on 2021/12/15.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    let homeTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        //네비게이션바
        navigationBarSetting()
        
        //테이블뷰
        tableViewSetting()
        
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
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        let nibName = UINib(nibName: "HomeTableViewCell", bundle: nil)

        homeTableView.register(nibName, forCellReuseIdentifier: "HomeTableViewCell")
        
        view.addSubview(homeTableView)
        
        homeTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        
        cell.sellImageView.image = UIImage(systemName: "star")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
