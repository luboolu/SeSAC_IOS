//
//  MovieTableViewCell.swift
//  TableView_practice
//
//  Created by 김진영 on 2021/10/19.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    static let identifier = "MovieTableViewCell"
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
