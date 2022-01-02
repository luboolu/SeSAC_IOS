//
//  TableViewCell.swift
//  SeSAC_FARM
//
//  Created by 김진영 on 2022/01/02.
//

import UIKit

struct PostTableViewCellModel {
    let nickname: UILabel
    let content: UITextView
    let date: UILabel
}

class PostTableViewCell: UITableViewCell {
    
    static let identifier = "PostTableViewCell"
    
    lazy var postTableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        
        label.backgroundColor = .lightGray
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        label.textColor = .darkGray
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 11)
        
        return label
    }()
    
    lazy var contentTextView: UITextView = {
        let textview = UITextView()
        
        textview.isEditable = false
        textview.backgroundColor = .clear
        textview.textColor = .black
        textview.textAlignment = .left
        textview.font = .systemFont(ofSize: 15)
        
        return textview
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        
        label.backgroundColor = .clear
        label.textColor = .darkGray
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 11)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("init!")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been impl")
    }
    
}

extension PostTableViewCell {
    public func bind(model: PostTableViewCellModel) {
        nicknameLabel.text = model.nickname.text
        contentTextView.text = model.content.text
        dateLabel.text = model.date.text
    }
}
