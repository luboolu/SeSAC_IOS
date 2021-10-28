//
//  StarringViewController.swift
//  SeSAC_TRENDMEDIA
//
//  Created by 김진영 on 2021/10/17.
//

import UIKit
import Kingfisher

class StarringViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var movieInfo: TMDBModel?
    var overviewExpanse = false
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var mainPosterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var overviewButton: UIButton!
    

    
    @IBOutlet weak var actorTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actorTableView.delegate = self
        actorTableView.dataSource = self
        
        //print(tvShow?.title)
 
        let url = URL(string: "https://image.tmdb.org/t/p/original/\(movieInfo!.backdropPath)")
        mainPosterImageView.kf.setImage(with: url)
        
        titleLabel.text = movieInfo?.title
        titleLabel.textColor = .white
        
        actorTableView.tableHeaderView = headerView
    }
    
    @IBAction func overviewButtonClicked(_ sender: UIButton) {
        print(#function)
        
        overviewExpanse = !overviewExpanse
        
        if overviewExpanse {
            //overviewButton.setImage(UIImage(named: "chevron.down"), for: .normal)
        } else {
            //overviewButton.setImage(UIImage(named: "chevron.up"), for: .normal)
        }

    }
    


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewCell") as? OverviewTableViewCell else {
                return UITableViewCell()
            }

            cell.overviewLabel.text = movieInfo?.overview

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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = sb.instantiateViewController(withIdentifier: "StarringDetailViewController") as? StarringDetailViewController else {
            print("ERROR")
            return
        }
        
        
        vc.title = movieInfo?.title

        self.navigationController?.pushViewController(vc, animated: true)

        
    }
    

}

