//
//  GenreTableViewCell.swift
//  SeSAC_TRENDMEDIA
//
//  Created by 김진영 on 2021/10/17.
//

import UIKit

class GenreTableViewCell: UITableViewCell {

    
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
