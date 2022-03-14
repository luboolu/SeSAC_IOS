//
//  UITableViewCell+Extension.swift
//  CLASS_WEEK13
//
//  Created by 김진영 on 2021/12/21.
//

import UIKit

protocol ReusableView {
    
    static var reuseIdentifier: String { get }
    
}

extension UITableViewCell: ReusableView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
}
