//
//  DramaCollectionViewCell.swift
//  SeSAC_TMDBDRAMA
//
//  Created by 김진영 on 2021/12/26.
//

import UIKit

class DramaCollectionViewCell: UICollectionViewCell{
    
    //static let reuseIdentifier = "DramaCollectionViewCell"
    
    let myImage: UIImageView = {

        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false

        return img

    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }


    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView(){

        
        //backgroundColor = .blue
        


    }

}




