//
//  HomeViewController.swift
//  CLASS_WEEK6
//
//  Created by 김진영 on 2021/11/01.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        

//        for family in UIFont.familyNames {
//            print(family)
//
//            for sub in UIFont.fontNames(forFamilyName: family) {
//                print("=========== \(sub)")
//            }
//
//        }

    }
    

    @IBAction func addButtonClicked(_ sender: UIButton) {
        
        print(#function)
        
        //1.스토리보드 특정
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        
        //2. 스토리보드 내 많은 뷰컨트롤러 중 전환하고자 하는 뷰컨트롤러 가져오기
        let vc = storyboard.instantiateViewController(withIdentifier: AddViewController.identifier) as! AddViewController
        
        //2-1. 네비게이션 컨트롤러 임베드
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        //nav.modalTransitionStyle = .partialCurl// full screen일때만 된다고 앱이 꺼진다!
        
        //3. present 방식으로 화면 전환
        self.present(nav, animated: true, completion: nil)
        
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        
        cell.categoryLable.backgroundColor = .yellow
        
        cell.collectionView.backgroundColor = .lightGray

        
        cell.collectionView.dataSource = self
        cell.collectionView.delegate = self
        cell.collectionView.tag = indexPath.row
        cell.collectionView.isPagingEnabled = true
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return indexPath.row == 1 ? 300 : 170
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.imageView.backgroundColor = .brown
        
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return CGSize(width: 100, height: 100)
        print(#function)
        //테이블뷰 셀의 인덱스 패스를 어떻게 가지고 와야 할까?
        if collectionView.tag == 0 {
            print(UIScreen.main.bounds.width)
            return CGSize(width: UIScreen.main.bounds.width, height: 100)
        } else {
            return CGSize(width: 150, height: 100)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
            if collectionView.tag == 0 {
                return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            } else {
                return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
            }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView.tag == 0 ? 0 : 10
    }
    
}

