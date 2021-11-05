//
//  CalendarViewController.swift
//  CLASS_WEEK6
//
//  Created by 김진영 on 2021/11/01.
//

import UIKit
import FSCalendar
import RealmSwift

class CalendarViewController: UIViewController {

    @IBOutlet weak var calendarView: FSCalendar!
    
    @IBOutlet weak var allCountLabel: UILabel!
    
    let localRealm = try! Realm()
    
    var tasks: Results<UserDiary>!
    
    override func viewDidLoad() {
        print(#function)
        super.viewDidLoad()

        calendarView.delegate = self
        calendarView.dataSource = self
        
        tasks = localRealm.objects(UserDiary.self)
        
        
        let recent = localRealm.objects(UserDiary.self).sorted(byKeyPath: "writeDate", ascending: false).first?.diaryTitle
        let full = localRealm.objects(UserDiary.self).filter("content != nil").count
        let favorite = localRealm.objects(UserDiary.self).filter("favorite = false")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        calendarView.reloadData()
        
        let allCount = getAllDiaryCountFromUserDiary()
        allCountLabel.text = "총 \(allCount)개를 썼다."
        //reloadInputViews()
    }
    
}

extension CalendarViewController: FSCalendarDelegate, FSCalendarDataSource {
    
    //ex. 11/2 3개의 일기가 있다면 event 3개를...없다면 0개, 1개먄 1개

    
    
    
//    func calendar(_ calendar: FSCalendar, titleFor date: Date) -> String? {
//        return "titla"
//    }
//
//    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
//        return "subtitle"
//    }
//
//    func calendar(_ calendar: FSCalendar, imageFor date: Date) -> UIImage? {
//        return UIImage(systemName: "star")
//    }
    
    //Date: 시분초까지 모두 동일해야 같은 날짜라고 판단함
    //1. 영국 표준시 기준으로 표기
    //2. Date Formatter
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {

        return tasks.filter("writeDate = %@", date).count
//
//        let format = DateFormatter()
//        format.dateFormat = "yyyyMMdd"
//        let test = "20211103"
//
//        print(date)
//
//        if format.date(from: test) == date {
//            return 3
//        } else {
//            return 1
//        }
//        return 2
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
    }
    
}
