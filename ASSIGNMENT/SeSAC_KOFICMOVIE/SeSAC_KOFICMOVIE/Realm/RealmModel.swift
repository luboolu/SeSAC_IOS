//
//  RealmModel.swift
//  SeSAC_KOFICMOVIE
//
//  Created by 김진영 on 2021/11/03.
//

import Foundation
import RealmSwift

//UserDiary: 테이블 이름
//@persisted: 컬럼 이름
class UserSearch: Object {
    
    //@Persisted var searchDate: String //날짜(필수)
    @Persisted var rank: List<String> //순위(필수)
    @Persisted var movieName: List<String> //영화 제목(필수)
    @Persisted var openDate: List<String> //영화 개봉일(필수)

    
    //PK(필수) : Int, String, UUID, ObjectID ->
    @Persisted(primaryKey: true) var searchDate: String
    
    convenience init(searchDate: String, rank: List<String>, movieName: List<String>, openDate: List<String>) {
        
        self.init()
        
        self.searchDate = searchDate
        self.rank = rank
        self.movieName = movieName
        self.openDate = openDate
        
    }
    

}
