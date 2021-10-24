//
//  BookViewController.swift
//  SeSAC_BOOK
//
//  Created by 김진영 on 2021/10/19.
//

import UIKit
import Kingfisher

class BookViewController: UIViewController {
    
    static let identifier = "BookViewController"

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
        
        //Navigation Bar Button Item 생성 - 닫기 버튼 & 필터 버튼
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(closeButtonClicked))
        
    }
    
    @objc func closeButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension BookViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvShowInformation.tvShow.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.identifier, for: indexPath) as? BookCollectionViewCell else { return UICollectionViewCell() }
        
        let row = tvShowInformation.tvShow[indexPath.row]
        
        let r : CGFloat = CGFloat.random(in: 0.5...0.9)
        let g : CGFloat = CGFloat.random(in: 0.5...0.9)
        let b : CGFloat = CGFloat.random(in: 0.5...0.9)
        
        cell.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        cell.layer.cornerRadius = 20
        cell.titleLabel.text = row.title
        cell.titleLabel.textColor = .white
        cell.rateLabel.text = String(row.rate)
        cell.rateLabel.textColor = .white
        
        let url = URL(string: row.backdropImage)
        cell.posterImageView.kf.setImage(with: url)
        
        return cell
    }
    
    
}
