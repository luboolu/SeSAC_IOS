//
//  HomeTableViewCell.swift
//  CLASS_WEEK6
//
//  Created by 김진영 on 2021/11/08.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    static let identifier = "HomeTableViewCell"
    
    @IBOutlet weak var categoryLable: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //collectionView.dataSource = self
        //collectionView.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
