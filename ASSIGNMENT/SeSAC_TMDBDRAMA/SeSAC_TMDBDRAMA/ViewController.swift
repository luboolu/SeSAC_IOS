//
//  ViewController.swift
//  SeSAC_TMDBDRAMA
//
//  Created by 김진영 on 2021/12/21.
//

import UIKit
import SnapKit
import Kingfisher

class ViewController: UIViewController {
    
    var apiService = APIService()
    var tmdbTvData: TmdbTv?
    
    let collectionViewReuseIdentifier = "DramaCollectionViewCell"
    
    
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
        
        apiService.requestTmdbTvTopRated(startPage: 1) { data in
        
            if let tmdbData = data {
                self.tmdbTvData = TmdbTv(page: tmdbData.page, results: tmdbData.results, totalPages: tmdbData.totalPages, totalResults: tmdbData.totalResults)
            }
            (self.tmdbTvData?.results[0])
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }

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
        //collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(DramaCollectionViewCell.self, forCellWithReuseIdentifier: collectionViewReuseIdentifier)
        
        collectionView.backgroundColor = .blue
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionViewReuseIdentifier, for: indexPath)
        if let row = self.tmdbTvData?.results[indexPath.row] {
            
            let myImage: UIImageView = {

                let img = UIImageView()
                img.translatesAutoresizingMaskIntoConstraints = false
                img.contentMode = .scaleAspectFit

                return img

            }()
            
            cell.addSubview(myImage)

            //제약조건 설정하기
            myImage.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
            myImage.leftAnchor.constraint(equalTo: cell.leftAnchor).isActive = true
            myImage.rightAnchor.constraint(equalTo: cell.rightAnchor).isActive = true
            myImage.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
            
            print(row.posterPath)
            
            let url = URL(string: "https://image.tmdb.org/t/p/original\(row.posterPath)")
            print(url)
            myImage.kf.setImage(with: url)
        }
        

        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
    }
    

    
}
