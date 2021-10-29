//
//  SearchResultTableViewCell.swift
//  SeSAC_TRENDMEDIA
//
//  Created by 김진영 on 2021/10/17.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var searchImageView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var overviewLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
