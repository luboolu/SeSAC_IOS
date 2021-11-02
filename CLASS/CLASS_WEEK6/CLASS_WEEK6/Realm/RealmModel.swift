//
//  RealmModel.swift
//  CLASS_WEEK6
//
//  Created by 김진영 on 2021/11/02.
//

import Foundation
import RealmSwift

//UserDiary: 테이블 이름
//@persisted: 컬럼 이름
class UserDiary: Object {
    
    @Persisted var diaryTitle: String // 제목(필수)
    @Persisted var content: String? //내용(옵션)
    @Persisted var writeDate = Date() //작성 날짜(필수)
    @Persisted var regDate = Date()//등록일(필수)
    @Persisted var favorite: Bool //즐겨찾기 기능(필수)
    
    //PK(필수) : Int, String, UUID, ObjectID ->
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(diaryTitle: String, content: String?, writeDate: Date, regDate: Date) {
        
        self.init()
        
        self.diaryTitle = diaryTitle
        self.content = content
        self.writeDate = writeDate
        self.regDate = regDate
        self.favorite = false
        
    }
    

}
