//
//  TagCollectionViewCell.swift
//  CLASS_WEEK4
//
//  Created by 김진영 on 2021/10/19.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TagCollectionViewCell"

    @IBOutlet weak var tagLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
