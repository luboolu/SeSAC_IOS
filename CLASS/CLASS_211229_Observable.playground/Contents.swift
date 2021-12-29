import UIKit

class Observable<T> {
    private var listener: ( (T) -> Void )?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}

class User {
    var name: String {
        didSet {
            changedName()
        }
    }
    
    init(_ name: String) {
        self.name = name
    }
    
    func changedName() {
        print("이름이 변경되었습니다.")
    }
}

let jack = User("")

jack.name
jack.name = "dae"
 

/////////////////////////////////////////////////////////
///
///

//struct Endpoint {
//    static let baseURL = "http://test.monocoding.com/"
//
//    static let signup = baseURL + "auth/local/register"
//    static let login = baseURL + "auth/local"
//    static let board = baseURL + "boards"
//}
//
//URLSession.shared.dataTask(with: Endpoint.signup)

enum Endpoint {
    case signup
    case login
    case boards
    case boardDetail(id: Int)
}

extension Endpoint {
    var url: URL {
        switch self {
        case .signup: return .makeEndPoint("auth/local/register")
        case .login: return .makeEndPoint("auth/local")
        case .boards: return .makeEndPoint("boards")
        case .boardDetail(let id): return .makeEndPoint("boards/\(id)")
        }
    }
}

extension URL {
    static let baseURL = "http://test.monocoding.com/"
    
    static func makeEndPoint(_ endpoint: String) -> URL {
        URL(string: baseURL + endpoint)!
    }
    
    static var login: URL {
        return makeEndPoint("auth/login")
    }
    
    static var signup: URL {
        return makeEndPoint("auth/local/register")
    }
    
    static var boards: URL {
        return makeEndPoint("boards")
    }
    
    static func boardsDetail(number: Int) -> URL {
        return makeEndPoint("boards/\(number)")
    }
}


URLSession.shared.dataTask(with: Endpoint.signup.url)
print(Endpoint.boardDetail(id: 2599).url)
