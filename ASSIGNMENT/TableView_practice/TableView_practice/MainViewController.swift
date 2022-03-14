//
//  MainViewController.swift
//  TableView_practice
//
//  Created by 김진영 on 2021/10/19.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mainTableView.delegate = self
        mainTableView.dataSource = self

        //headerView nib register
        let headerNibName = UINib(nibName: MovieTableViewHeader.identifier, bundle: nil)
        mainTableView.register(headerNibName, forCellReuseIdentifier: MovieTableViewHeader.identifier)
        
        
        //nib register
        let nibName = UINib(nibName: MovieTableViewCell.identifier, bundle: nil)
        mainTableView.register(nibName, forCellReuseIdentifier: MovieTableViewCell.identifier)
    }

}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    //TableView Cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        
        cell.moviePosterImageView.image = UIImage(systemName: "heart")
        cell.movieTitleLabel.text = "Heart"
        
        return cell
    }
    
    //TableView Header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        print(#function)
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MovieTableViewHeader.identifier) as? MovieTableViewHeader else {
            print("header return")
            return UIView()
        }
        
        print(header.headerLabel.text ?? "default")
        
        return header
    }
}

