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
    
    var data: [String] = [] {
        didSet {
            collectionView.reloadData()
            categoryLable.text = "\(data.count)개의 데이터"
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}

extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else {
            print("return")
            return UICollectionViewCell()
        }
        
        if collectionView.tag == 0 {
            cell.imageView.backgroundColor = .green
        } else {
            cell.imageView.backgroundColor = .brown
        }
        
        cell.contentLable.text = data[indexPath.row]
        
        
        
        return cell
    }
    



    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return CGSize(width: 100, height: 100)
        print(#function)
        //테이블뷰 셀의 인덱스 패스를 어떻게 가지고 와야 할까?
        if collectionView.tag == 0 {
            print(UIScreen.main.bounds.width)
            return CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        } else {
            return CGSize(width: 150, height: 100)
        }
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        print(#function)
//        if collectionView.tag == 0 {
//            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        } else {
//            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
//        }
//    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView.tag == 0 ? 0 : 10
    }
    
}
