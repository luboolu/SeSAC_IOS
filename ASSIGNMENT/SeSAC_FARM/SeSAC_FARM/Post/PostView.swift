//
//  PostView.swift
//  SeSAC_FARM
//
//  Created by 김진영 on 2022/01/02.
//

import UIKit
import SnapKit

class PostView: UIView, ViewRepresentable {
    
    var postTableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        setupConstraints()
    }

    func setupView() {
        self.backgroundColor = .white
        postTableView.backgroundColor = .orange
        
        addSubview(postTableView)
        
        postTableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        postTableView.delegate = self
        postTableView.dataSource = self
        
        
    }
    
    func setupConstraints() {
        postTableView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-20)
        }
    }
    
    
}

extension PostView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier) as? PostTableViewCell else {
            return UITableViewCell()
        }
        
        cell.nicknameLabel.text = "바미"
        cell.contentTextView.text = "새싹농장 가입인사 드려요 *^^*"
        cell.dateLabel.text = "01/02"
        
        return cell
    }
    
    
}
