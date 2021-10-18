//
//  MovieCastViewController.swift
//  CLASS_211012
//
//  Created by 김진영 on 2021/10/15.
//

import UIKit
//tableviewcontroller로 만든게 아니기 때문에, tableview 관련 메소드를 사용하기 위해서는 프로토콜을 추가해주어야 한다.
//또한 스토리보드에서 tableview에 datasource와 delegate에 연결해주어야 한다. 또는 코드로도 가능
class MovieCastViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var castTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableview와 delefate, dataSource 연결
        castTableView.delegate = self
        castTableView.dataSource = self

    }
    
    //tableview controller와 다르게 override없이 사용하게 됨 프로토콜로 불러왔기 때문에!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CastCell") else { return UITableViewCell()}
        
        cell.textLabel?.text = "CAST \(indexPath.row)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    


}
