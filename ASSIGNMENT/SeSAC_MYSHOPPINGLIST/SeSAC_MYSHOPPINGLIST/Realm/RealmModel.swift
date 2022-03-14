//
//  RealmModel.swift
//  SeSAC_MYSHOPPINGLIST
//
//  Created by 김진영 on 2021/11/05.
//

import Foundation

import RealmSwift

//UserDiary: 테이블 이름
//@persisted: 컬럼 이름
class UserList: Object {
    
    @Persisted var content: String // 할일
    @Persisted var favorite: Bool // 즐겨찾기 여부
    @Persisted var check: Bool // 완료 여부
    
    //PK(필수) : Int, String, UUID, ObjectID ->
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(content: String, favorite: Bool, check: Bool) {
        
        self.init()
        
        self.content = content
        self.favorite = favorite
        self.check = check
    }
    

}
