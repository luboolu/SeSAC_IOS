//
//  TableViewCellRepresentable.swift
//  CLASS_WEEK13
//
//  Created by 김진영 on 2021/12/21.
//

import UIKit

protocol TableViewCellRepresentable {
    
    var numberOfSection: Int { get }
    var numberOfRowsInSection: Int { get }
    var heightOfRowAt: CGFloat { get }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    
}
