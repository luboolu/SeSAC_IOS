//
//  MovieDetailViewController.swift
//  CLASS_211012
//
//  Created by 김진영 on 2021/10/15.
//

import UIKit

class MovieDetailViewController: UIViewController, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //Pass Data1. 전달받을 공간
//    var movieTitle: String?
//    var releaseDate: String?
//    var runtime: Int?
//    var overview: String?
//    var rate: Double?
    
    var movieData: Movie?
    
    let pickerList: [String] = ["감자", "고구마", "파인애플", "자두", "복숭이"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        5
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(row)
    }

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var overviewTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Pass Data2
//        titleTextField.text = movieTitle
//        overviewTextView.text = overview
//
//        print(runtime, rate, releaseDate)
        
        titleTextField.text = movieData?.title
        overviewTextView.text = movieData?.overview
        
        print(movieData?.rate, movieData?.runtime, movieData?.releaseDate)
        
        
        //TextField의 inputView
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        
        //atePicker.preferredDatePickerStyle = .wheels
        
        
        titleTextField.inputView = pickerView
        

        overviewTextView.delegate = self
        
        //텍스트뷰 플레이스 홀더: 글자, 글자 색상
        //overviewTextView.text = "이 곳에 줄거리를 남겨보세요"
        overviewTextView.textColor = .lightGray
        
    }
    
    //커서가 끝나는 지점
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }

    //커서가 켜지는 지점
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "이 곳에 줄거리를 남겨보세용"
            textView.textColor = .lightGray
        }
    }

}
