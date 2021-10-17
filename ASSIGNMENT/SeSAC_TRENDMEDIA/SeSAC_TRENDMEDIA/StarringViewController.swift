//
//  StarringViewController.swift
//  SeSAC_TRENDMEDIA
//
//  Created by 김진영 on 2021/10/17.
//

import UIKit

class StarringViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var actorTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actorTableView.delegate = self
        actorTableView.dataSource = self
        
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
