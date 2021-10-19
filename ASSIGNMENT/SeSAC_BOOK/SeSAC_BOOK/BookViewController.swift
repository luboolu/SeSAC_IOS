//
//  BookViewController.swift
//  SeSAC_BOOK
//
//  Created by 김진영 on 2021/10/19.
//

import UIKit
import Kingfisher

class BookViewController: UIViewController {

    let tvShowInformation = TvShowInformation()
    
    @IBOutlet weak var bookCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookCollectionView.delegate = self
        bookCollectionView.dataSource = self
        
        let nibName = UINib(nibName: BookCollectionViewCell.identifier, bundle: nil)
        bookCollectionView.register(nibName, forCellWithReuseIdentifier: BookCollectionViewCell.identifier)
        
        //collection view flow layout 설정
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        let width = UIScreen.main.bounds.width - (spacing * 3)
        layout.itemSize = CGSize(width: width / 2, height: (width / 2))
        print(UIScreen.main.bounds.width, width / 2, width / 2)
        layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .vertical
        bookCollectionView.collectionViewLayout = layout
        
    }
    
}

extension BookViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvShowInformation.tvShow.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as? BookCollectionViewCell else { return UICollectionViewCell() }
        
        let row = tvShowInformation.tvShow[indexPath.row]
        
        let r : CGFloat = CGFloat.random(in: 0.7...1)
        let g : CGFloat = CGFloat.random(in: 0.7...1)
        let b : CGFloat = CGFloat.random(in: 0.7...1)
        
        cell.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        cell.layer.cornerRadius = 20
        cell.titleLabel.text = row.title
        cell.rateLabel.text = String(row.rate)
        
        let url = URL(string: row.backdropImage)
        cell.posterImageView.kf.setImage(with: url)
        
        return cell
    }
    
    
}
