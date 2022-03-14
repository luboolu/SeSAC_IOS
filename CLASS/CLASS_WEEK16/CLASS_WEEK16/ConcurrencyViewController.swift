//
//  ConcurrencyViewController.swift
//  CLASS_WEEK16
//
//  Created by 김진영 on 2022/01/12.
//

import UIKit

class ConcurrencyViewController: UIViewController {
    
    @IBOutlet weak var firstImage1: UIImageView!
    @IBOutlet weak var secondImage1: UIImageView!
    @IBOutlet weak var thridImage1: UIImageView!
    
    let url1 = URL(string: "https://apod.nasa.gov/apod/image/2201/OrionStarFree3_Harbison_5000.jpg")!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func basic(_ sender: UIButton) {
        
        print("HELLO WORLD")
        
        for i in 1...100 {
            print(i, terminator: " ")
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("BYE BYE WORLD")
        
    }
    
    @IBAction func mainAsync(_ sender: UIButton) {
        
        print("HELLO WORLD")
        
        DispatchQueue.main.async {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        

        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        
        print("BYE BYE WORLD")
        
        
    }
    
    @IBAction func globalSyncAsync(_ sender: UIButton) {
        
        print("HELLO WORLD")
        
        //global sync: 메인 쓰레드로 동작하는 거랑 유사한게 아닌가?
        //다른 쓰레드로 동기적으로 보내는 코드라도 실질적으로는 메인 쓰레드에서 일함
        
//        DispatchQueue.global().async {
//            for i in 1...100 {
//                print(i, terminator: " ")
//            }
//        }

        for i in 1...100 {
            DispatchQueue.global().async {
                print(i, terminator: " ")
            }
        }
        
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("BYE BYE WORLD")
    }
    
    
    @IBAction func globalQoS(_ sender: UIButton) {
        
        let queue = DispatchQueue(label: "concurrnetJack", qos: .userInteractive, attributes: .concurrent) //serial
        
        //QoS: Quality of Service
        DispatchQueue.global(qos: .userInitiated).async {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global(qos: .userInteractive).async {
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global(qos: .utility).async {
            for i in 202...300 {
                print(i, terminator: " ")
            }
        }
        
    }
    
    
    @IBAction func dispatchGroup(_ sender: UIButton) {
        
        let group = DispatchGroup()
        
        DispatchQueue.global().async(group: group) {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for i in 201...300 {
                print(i, terminator: " ")
            }
        }
        
        group.notify(queue: .main) {
            print("끝")
            self.view.backgroundColor = .red
        }
        
    }
    
    @IBAction func urlsessionDispatchGroup(_ sender: UIButton) {
        
//        request(url: url1) { image in
//            print("image1")
//        }
        
    }
    
    
    
    func request(url: URL, completionHandler: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completionHandler(UIImage(systemName: "star"))
                return
            }
            
            let image = UIImage(data: data)

        }.resume()
    }
    
    
    @IBAction func asyncAwait(_ sender: UIButton) {
        
        Task {
            do {
                let request1 = try await newRequest(url: url1)
                
                firstImage1.image = request1
            } catch {
                print("error")
            }
        }
        
    }
    
    
    func newRequest(url: URL) async throws -> UIImage {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError.statusCodeError
        }
        
        guard let image = UIImage(data: data) else {
            throw APIError.unsupportedImage
        }
        
        return image
    }
    
    
    
    @IBAction func raceCondition(_ sender: UIButton) {
        
        var nickname = "Jack"
        let group = DispatchGroup()
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "미묘한도사"
            print("First: \(nickname)")
        }
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "쭙쭙이"
            print("Second: \(nickname)")
        }
        
        group.notify(queue: .main) {
            print("Result: \(nickname)")
        }
    }
    
    
    
    
}

enum APIError: Error {
    case statusCodeError
    case unsupportedImage
}
