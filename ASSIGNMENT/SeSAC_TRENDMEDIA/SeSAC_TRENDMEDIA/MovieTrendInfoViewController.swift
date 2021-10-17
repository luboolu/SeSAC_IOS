//
//  MovieTrendInfoViewController.swift
//  SeSAC_TRENDMEDIA
//
//  Created by 김진영 on 2021/10/17.
//

import UIKit

class MovieTrendInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tvShowInformation = TvShowInformation()
    
    
    @IBOutlet weak var InfoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        InfoTableView.delegate = self
        InfoTableView.dataSource = self
        
        InfoTableView.rowHeight = UITableView.automaticDimension

        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tvShowInformation.tvShow.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "GenreCell") as? GenreTableViewCell else {
                return UITableViewCell()
            }
            
            let row = tvShowInformation.tvShow[indexPath.section]
            
            cell.releaseDateLabel.text = row.releaseDate
            cell.releaseDateLabel.font = .systemFont(ofSize: 15, weight: .medium)
            cell.releaseDateLabel.textColor = .lightGray
            
            cell.genreLabel.text = "#" + row.genre
            cell.genreLabel.font = .systemFont(ofSize: 20, weight: .medium)
            cell.genreLabel.textColor = .black
            
            return cell
            
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PosterCell") as? PosterTableViewCell else {
                return UITableViewCell()
            }
            
            let row = tvShowInformation.tvShow[indexPath.section]
            let url = URL(string: row.backdropImage)
            //DispatchQueue를 쓰는 이유 -> 이미지가 클 경우 이미지를 다운로드 받기 까지 잠깐의 멈춤이 생길수 있다. (이유 : 싱글 쓰레드로 작동되기때문에)
            //DispatchQueue를 쓰면 멀티 쓰레드로 이미지가 클경우에도 멈춤이 생기지 않는다.
            //라고 하는데...아직은 잘 모르겠다.

            DispatchQueue.global().async {
                let data = try?
                Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async
                {
                    cell.posterImageView.image = UIImage(data: data!)
                }
            }
            
            cell.rateNameLabel.text = "평점"
            cell.rateNameLabel.font = .systemFont(ofSize: 15, weight: .medium)
            cell.rateNameLabel.backgroundColor = .purple
            
            cell.rateNumLabel.text = String(row.rate)
            cell.rateNumLabel.font = .systemFont(ofSize: 15, weight: .medium)
            cell.rateNumLabel.backgroundColor = .white
            
          
            
            return cell
        } else if indexPath.row == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell") as? InfoTableViewCell else {
                return UITableViewCell()
            }
            
            let row = tvShowInformation.tvShow[indexPath.section]
            
            cell.movieTitleLable.text = row.title
            cell.movieTitleLable.font = .systemFont(ofSize: 25)
            
            cell.movieCastLabel.text = row.starring
            cell.movieCastLabel.font = .systemFont(ofSize: 15, weight: .light)
            
            
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell") else {
                return UITableViewCell()
            }
            
            return cell
        }

        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 1 {
            return 300
        } else if indexPath.row == 2 {
            return 88
        } else {
            return 44
        }

    }
    
    
    @IBAction func searchButtonClicked(_ sender: UIBarButtonItem) {
        print(#function)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = sb.instantiateViewController(withIdentifier: "StarringViewController") as? StarringViewController else {
            print("ERROR")
            return
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }


    

}
