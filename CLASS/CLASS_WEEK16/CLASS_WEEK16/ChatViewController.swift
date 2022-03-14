//
//  ChatViewController.swift
//  CLASS_WEEK16
//
//  Created by 김진영 on 2022/01/13.
//

import UIKit

import Alamofire
import SocketIO

class ChatViewController: UIViewController {
    
    let tableView = UITableView()
    let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxZTBjNTg4YmUzNDViZDllZDBjN2QxMCIsImlhdCI6MTY0MjEyMDU4NCwiZXhwIjoxNjQyMjA2OTg0fQ.EmJ3Itk5Go9ekVenZVIuMvqgGynHvOBYTZ2ufNmSACE"
    let name = "bob"
    
    let url = "http://test.monocoding.com:1233/chats"
    var list: [Chat] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        view.addSubview(tableView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(getMessage(notification:)), name: NSNotification.Name("getMessage"), object: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(postChating))
        
        requestChats()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //화면이 사라지면, 소켓 연결을 끊는다
        SocketIOManager.shared.closeConnection()
    }
    
    @objc func getMessage(notification: NSNotification) {
        
        let chat = notification.userInfo!["chat"] as! String
        let name = notification.userInfo!["name"] as! String
        let createdAt = notification.userInfo!["createdAt"] as! String
        
        let value = Chat(text: chat, userID: "", name: name, username: "", id: "", createdAt: createdAt, updatedAt: "", v: 0, lottoID: "")
        
        list.append(value)
        self.tableView.reloadData()
        self.tableView.scrollToRow(at: IndexPath(row: self.list.count - 1, section: 0), at: .bottom, animated: false)
    }
    
    @objc func postChating() {
        postChat()
    }
    
    func postChat() {
        let header: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Accept": "applecation/json"
        ]
        
        let array = ["'ㅅ'"]
        
        AF.request(url, method: .post, parameters: ["text": "\(array.randomElement()!)"], encoder: JSONParameterEncoder.default , headers: header).responseDecodable(of: [Chat].self) { data in
            print("post chat")
        }
    }
    
    //DB(last time chat): 나중엔 DB에 기록된 채팅의 마지막 시간을 서버에 요청, 새로운 데이터만 
    func requestChats() {

        let header: HTTPHeaders = [
            "Authorization": "Bearer \(token)",
            "Accept": "applecation/json"
        ]
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: [Chat].self) { response in
            switch response.result {
            case .success(let value):
                self.list = value
                self.tableView.reloadData()
                self.tableView.scrollToRow(at: IndexPath(row: self.list.count - 1, section: 0), at: .bottom, animated: false)
                
                //소켓 연결
                SocketIOManager.shared.establishConnection()
            case .failure(let error):
                print("Error", error)
            }
        }

    }



}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        var content = cell.defaultContentConfiguration()
        
        let data = list[indexPath.row]
        
        if data.name == name {
            //my Cell 사용
            content.text = data.text
            //content.image = UIImage(systemName: "star.fill")
            cell.backgroundColor = .yellow
            cell.contentConfiguration = content
            
            return cell
        } else {
            content.text = data.text
            //content.image = UIImage(systemName: "star.fill")
            cell.backgroundColor = .orange
            cell.contentConfiguration = content
            
            return cell
        }
        

        
    }
    

    
    
}

struct Chat: Codable {
    let text, userID, name, username: String
    let id, createdAt, updatedAt: String
    let v: Int
    let lottoID: String

    enum CodingKeys: String, CodingKey {
        case text
        case userID = "userId"
        case name, username
        case id = "_id"
        case createdAt, updatedAt
        case v = "__v"
        case lottoID = "id"
    }
}
