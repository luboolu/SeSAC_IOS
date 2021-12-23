//
//  NASAViewController.swift
//  CLASS_WEEK13
//
//  Created by 김진영 on 2021/12/22.
//

import UIKit

class NASAViewController: BaseViewController {
    
    let imageView = UIImageView()
    let label = UILabel()
    
    var session: URLSession!
    
    var buffer: Data? {
        didSet {
            let result = Double(buffer?.count ?? 0) / total
            label.text = "\(result * 100)%"
        }
    }
    
    var total: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buffer = Data()
        
        configure()
        setupConstraints()
        
        request()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //completion handler가 아니라 session delegate를 사용할때는 리소스 정리가 필요함
        
        //실행중인 태스크 완료 후 리소스 정리
        session.finishTasksAndInvalidate()
        //리소스 싹 다 정리...실행중인 테스크가 있더라도 그만함
        session.invalidateAndCancel()

    }
    
    override func configure() {
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        label.textAlignment = .center
        label.backgroundColor = .white
        label.textColor = .black
        label.text = "0%"
    }
    
    override func setupConstraints() {
        view.addSubview(imageView)
        view.addSubview(label)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(100)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
    func request() {
        let url = URL(string: "https://apod.nasa.gov/apod/image/2112/WinterSolsticeMW_Seip_1079.jpg")!
        print("request start")
        
        
        //받아오려는 용량이 큰 경우...
        //클로져로 처리하는것 보다 session delegate를 사용하는게 낫다?
        //URLSession.shared.dataTask(with: url).resume()
        
        //let configuration = URLSessionConfiguration.default
        //configuration.allowsCellularAccess = false
        
        session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        //URLSession(configuration: configuration).dataTask(with: url).resume()
        session.dataTask(with: url).resume()

    }
    
    
}

//delegate를 사용하면 통신과 관련해서 좀 더 세부적인 대응을 할 수 있다.
extension NASAViewController: URLSessionDataDelegate {
    
    //서버에서 최초로 응답 받은 경우 호출(상태코드)
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        print(#function)
        if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
            //문제가 없다면
            //label.text = response.value(forHTTPHeaderField: "Content-Length")
            total = Double(response.value(forHTTPHeaderField: "Content-Length")!)!
            return .allow
        } else {
            //문제가 있다면
            return .cancel
        }
    }
    

    
    //서버에서 데이터를 받을 때마다 반복적으로 호출됨
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print(data)
        buffer?.append(data)
    }
    
    
    //응답이 완료되었을떄: nil
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print(#function)
        if let error = error {
            print("오류가 발생했습니다", error)
        } else {
            print("성공") //completionHandler
            
            //buffer에 Data가 모두 채워졌을 때, 이미지로 변환
            guard let buffer = buffer else {
                print("buffer error")
                return
            }
            
            let image = UIImage(data: buffer)
            imageView.image = image
        }
    }
    
    
}
