//
//  Constraints.swift
//  SeSAC_TRENDMEDIA
//
//  Created by 김진영 on 2021/10/27.
//

import Foundation

struct APIKEY {
    static let NAVER_ID = "uesxBpa4kC9tztddyWGr"
    static let NAVER_SECRETE = "GRMNLkQCNF"
    static let TMDB = "5b2646eba70f38e9484223101e68395f"
}

struct Endpoint {
    static let NaverMovieSearchURL = "https://openapi.naver.com/v1/search/movie.json"
    static let tmdbTrendURL = "https://api.themoviedb.org/3/trending/all/day"
}
