import Foundation

protocol MyDelegate: AnyObject {
    func sendData(_ data: String)
}

class Main: MyDelegate {
    
    lazy var detail: Detail = {
        let view = Detail()
        view.delegate = self
        return view
    }()
    
    func sendData(_ data: String) {
        print("\(data)를 전달받았습니다.")
    }
    
}

class Detail {
    weak var delegate: MyDelegate?
    
    func dismiss() {
        delegate?.sendData("안녕")
    }
    
    deinit {
        print("Detail Deinit")
    }
}

var main: Main? = Main()
main = nil









