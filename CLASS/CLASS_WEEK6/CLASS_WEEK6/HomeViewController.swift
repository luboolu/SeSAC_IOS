//
//  HomeViewController.swift
//  CLASS_WEEK6
//
//  Created by 김진영 on 2021/11/01.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let array = [
        Array(repeating: "a", count: 20),
        Array(repeating: "b", count: 2),
        Array(repeating: "c", count: 5),
        Array(repeating: "d", count: 13),
        Array(repeating: "e", count: 18),
        Array(repeating: "f", count: 4),
        Array(repeating: "g", count: 52)
    ]
    
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
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        
        cell.data = array[indexPath.row] //데이터 넘기기
        
        
        //cell.categoryLable.text = "\(array[indexPath.row])"
        cell.categoryLable.backgroundColor = .yellow
        
        cell.collectionView.backgroundColor = .lightGray

        
        
        cell.collectionView.tag = indexPath.row
        cell.collectionView.isPagingEnabled = true
        //cell.collectionView.reloadData()
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return indexPath.row == 1 ? 300 : 170
    }

}


