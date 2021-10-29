//
//  BookCollectionViewCell.swift
//  SeSAC_BOOK
//
//  Created by 김진영 on 2021/10/19.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {

    static let identifier = "BookCollectionViewCell"
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var rateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
