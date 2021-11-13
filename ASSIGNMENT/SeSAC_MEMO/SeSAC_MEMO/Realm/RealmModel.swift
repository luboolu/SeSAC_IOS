//
//  RealmModel.swift
//  SeSAC_MEMO
//
//  Created by 김진영 on 2021/11/08.
//

import Foundation

import RealmSwift

//UserDiary: 테이블 이름
//@persisted: 컬럼 이름
class UserMemoList: Object {
    
    @Persisted var title: String   //메모 제목
    @Persisted var content: String //메모 내용
    @Persisted var isFixed: Bool   //메모 고정 여부
    @Persisted var date: Date      //메모 작성 날짜

    
    //PK(필수) : Int, String, UUID, ObjectID ->
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(title: String, content: String, isFixed: Bool, date: Date) {
        
        self.init()
        
        self.title = title
        self.content = content
        self.isFixed = isFixed
        self.date = date
        

    }
    

}
