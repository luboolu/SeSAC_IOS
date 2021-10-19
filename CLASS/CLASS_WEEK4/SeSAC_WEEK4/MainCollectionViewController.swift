//
//  MainCollectionViewController.swift
//  CLASS_WEEK4
//
//  Created by 김진영 on 2021/10/19.
//

import UIKit

class MainCollectionViewController: UIViewController {
    
    //1. CollectionView 아웃렛 연결
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var tagCollectionView: UICollectionView!
    
    var mainArray = Array(repeating: false, count: 100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainCollectionView.tag = 100
        tagCollectionView.tag = 200

        //3. Delegate
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        
        //4. XIB
        let nibName = UINib(nibName: MainCollectionViewCell.identifier, bundle: nil)
        mainCollectionView.register(nibName, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        
        let nibName_tag = UINib(nibName: TagCollectionViewCell.identifier, bundle: nil)
        tagCollectionView.register(nibName_tag, forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
        
        
        //collection view flow layout 설정
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        let width = UIScreen.main.bounds.width - (spacing * 4)
        layout.itemSize = CGSize(width: width / 3, height: (width / 3) * 1.2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.scrollDirection = .vertical
        mainCollectionView.collectionViewLayout = layout
        
        mainCollectionView.backgroundColor = .lightGray
        
        //tag collection view flow layout 설정
        let tagLayout = UICollectionViewFlowLayout()
        let tagSpacing: CGFloat = 8
        //let width_tag = UIScreen.main.bounds.width - (spacing_tag * 4)
        tagLayout.itemSize = CGSize(width: 100, height: 40)

       
        tagLayout.minimumInteritemSpacing = tagSpacing
        tagLayout.scrollDirection = .horizontal
        tagLayout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tagCollectionView.collectionViewLayout = tagLayout
        
        tagCollectionView.backgroundColor = .systemPink
    }
    
    @objc func heartButtonClicked(selectButton: UIButton) {
        //tag == indexPath.item
        print("\(selectButton.tag) 버튼 클릭")
        
//        if mainArray[selectButton.tag] == true {
//            mainArray[selectButton.tag] = false
//        } else {
//            mainArray[selectButton.tag] = true
//        }
        
        mainArray[selectButton.tag] = !mainArray[selectButton.tag]
        
        //전체 모든 cell을 갱신함, cell이 몇천개가 되면 시간이 너무 오래 걸리게 됨
        //mainCollectionView.reloadData()
        
        //딱 하나의 cell을 갱신할수도 있음!
        mainCollectionView.reloadItems(at: [IndexPath(item: selectButton.tag, section: 0)])
        
    }
    
}

//2. CollectionView Protocol
extension MainCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //2.tag를 이용하는 방법
//        if colleciontView.tag == 100 {
//            return 10
//        }
        //1.collectionView 인자를 사용하는 방법
        if collectionView == tagCollectionView {
            return 10
        } else {
            return mainArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == tagCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as? TagCollectionViewCell else { return TagCollectionViewCell() }
            
            
            cell.tagLabel.text = "안녕하세요"
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 5
            
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
            
            let item = mainArray[indexPath.item]
            
            cell.mainImageView.backgroundColor = .blue
            
            let image = item == true ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
            cell.heartButton.setImage(image, for: .normal)
            //어디의 하트 버튼이 눌렸는지 알아볼수있게
            cell.heartButton.tag = indexPath.item
            cell.heartButton.addTarget(self, action: #selector(heartButtonClicked(selectButton: )), for: .touchUpInside)
            
            return cell
        }
        
    }

}

