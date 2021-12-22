//
//  ViewController.swift
//  SeSAC_TMDBDRAMA
//
//  Created by 김진영 on 2021/12/21.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    
    let collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let width = UIScreen.main.bounds.width - (spacing * 4) - 0
        let height = UIScreen.main.bounds.height - (spacing * 5) - 0
        
        
        layout.itemSize = CGSize(width: width / 3, height: (height / 4))
        //print(UIScreen.main.bounds.width, width / 3, width / 3)
        layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: 0, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .green
        
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        view.addSubview(collectionView)
        
        view.backgroundColor = .white
        
        //searchControllerSetting()
        collectionViewSetting()

    }
    
    func searchControllerSetting() {
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "검색할 드라마 제목을 입력해주세요"
        searchController.hidesNavigationBarDuringPresentation = false
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
    }
    
    func collectionViewSetting() {
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(self.view).offset(0)
            make.top.bottom.equalTo(self.view).offset(0)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        cell.backgroundColor = .yellow
        
        return cell
    }
    

    
}
