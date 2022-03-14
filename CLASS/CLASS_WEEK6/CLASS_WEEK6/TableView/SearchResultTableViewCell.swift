//
//  SearchResultTableViewCell.swift
//  CLASS_WEEK6
//
//  Created by 김진영 on 2021/11/02.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    static let identifier = "SearchResultTableViewCell"
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet var searchImageView: UIImageView!
    
    func configureCell(row: UserDiary) {
        titleLabel.text = row.diaryTitle
        //dateLabel.text = format.string(from: row.writeDate)
        contentLabel.text = row.content
        contentLabel.numberOfLines = 0
        //searchImageView.image = loadImageFromDocumentDirectory(imageName: "\(row._id).png")
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
