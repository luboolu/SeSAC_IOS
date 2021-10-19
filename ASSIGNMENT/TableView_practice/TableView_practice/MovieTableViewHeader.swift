//
//  MovieTableViewHeader.swift
//  TableView_practice
//
//  Created by 김진영 on 2021/10/19.
//

import UIKit

class MovieTableViewHeader: UITableViewHeaderFooterView {
    
    static let identifier = "MovieTableViewHeader"

    @IBOutlet weak var headerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print(#function)
        // Initialization code
    }
    
    
}
