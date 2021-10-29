//
//  TMDBModel.swift
//  SeSAC_TRENDMEDIA
//
//  Created by 김진영 on 2021/10/28.
//

import Foundation

//TMDB Trend API
struct TMDBModel {
    let id: Int
    let title: String
    let backdropPath: String
    let voteCount: Int
    let overview: String
    let popularity: Double
    let posterPath: String
    let video: Bool
    let mediaType: String
    let voteAverage: Double
    let adult: Bool
    let originalLanguage: String
    let genreID: [Int]
    let releaseDate: String
    let originalTitle: String
}

//TMDB Get Cast API
struct TMDBGetCastModel {
    let gender: Int
    let id: Int
    let department: String
    let name: String
    let originalName: String
    let porofilePath: String
    let character: String
    let creditID: String
}


//TMDB CastAPI
struct TMDBCastModel {
    let genreID: [Int]
    let overview: String
    let originalLanguage: String
    let originalTitle: String
    let posterPath: String
    let backdropPath: String
    let voteAverage: Double
    let title: String
    let releaseDate: String
    let id: Int
    let character: String
}
