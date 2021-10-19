//
//  StarringViewController.swift
//  SeSAC_TRENDMEDIA
//
//  Created by 김진영 on 2021/10/17.
//

import UIKit
import Kingfisher

class StarringViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tvShow: TvShow?
    
    @IBOutlet weak var mainPosterImageView: UIImageView!

    @IBOutlet weak var actorTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actorTableView.delegate = self
        actorTableView.dataSource = self
        
        //print(tvShow?.title)
 
        let url = URL(string: tvShow!.backdropImage)
        mainPosterImageView.kf.setImage(with: url)
        
        let nibName = UINib(nibName: OverviewTableViewCell.identifier, bundle: nil)
        actorTableView.register(nibName, forCellReuseIdentifier: OverviewTableViewCell.identifier)

        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: OverviewTableViewCell.identifier) as? OverviewTableViewCell else {
                return UITableViewCell()
            }
            
            cell.overviewLabel.text = tvShow!.overview
            
            return cell
            
            
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ActorCell") as? ActorTableViewCell else {
                return UITableViewCell()
            }
            
            
            cell.actorImageView.image = UIImage(named: "nevertheless")
            
            cell.actorProfile1.text = "주연배우"
            cell.actorProfile1.font = .systemFont(ofSize: 18, weight: .light)
            
            cell.actorProfile2.text = "주연배우"
            cell.actorProfile2.font = .systemFont(ofSize: 15, weight: .light)
            
            return cell
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row != 0 {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            
            guard let vc = sb.instantiateViewController(withIdentifier: "StarringDetailViewController") as? StarringDetailViewController else {
                print("ERROR")
                return
            }
            
            
            vc.title = tvShow!.title

            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    

}
