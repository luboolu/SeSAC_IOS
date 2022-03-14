//
//  SocketManager.swift
//  CLASS_WEEK16
//
//  Created by 김진영 on 2022/01/14.
//

import Foundation
import SocketIO

class SocketIOManager: NSObject {
    static let shared = SocketIOManager()
    
    let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxZTBjNTg4YmUzNDViZDllZDBjN2QxMCIsImlhdCI6MTY0MjEyMDU4NCwiZXhwIjoxNjQyMjA2OTg0fQ.EmJ3Itk5Go9ekVenZVIuMvqgGynHvOBYTZ2ufNmSACE"
    
    //서버와의 매세지리를 주고받기 위한 클래스
    var manager: SocketManager!
    
    //클라이언트 소켓
    var socket: SocketIOClient!
    
    override init() {
        super.init()
        
        let url = URL(string: "http://test.monocoding.com:1233")!
        
        manager = SocketManager(socketURL: url, config: [
            .log(true),
            .compress,
            .extraHeaders(["auth": token])
            ])
        
        socket = manager.defaultSocket // "/"로 된 룸
        
        //소켓 연결 메서드
        socket.on(clientEvent: .connect) { data, ack in
            print("SOCKET IS CONNECTED", data, ack)
        }
        
        //소켓 연결 해제 메서드
        socket.on(clientEvent: .disconnect) { data, ack in
            print("SOCKET IS DISCONNECTED", data, ack)
        }
        
        
        //소켓 채팅 듣는 메서드, sesac 이벤트로 날아온 데이터를 수신
        //데이터 수신 -> 디코딩 -> 모델에 추가 -> 갱신
        socket.on("sesac") { data, ack in
            print("SESAC RECIEVE", data, ack)
            let data = data[0] as! NSDictionary
            let chat = data["text"] as! String
            let name = data["name"] as! String
            let createdAt = data["createdAt"] as! String
            print("CHECK: ", data, chat, name, createdAt)
            
            NotificationCenter.default.post(name: NSNotification.Name("getMessage"), object: self, userInfo: ["chat": chat, "name": name, "createdAt": createdAt])
        }
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
}
