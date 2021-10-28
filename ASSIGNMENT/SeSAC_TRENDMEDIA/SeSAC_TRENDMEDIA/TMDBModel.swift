//
//  TMDBModel.swift
//  SeSAC_TRENDMEDIA
//
//  Created by 김진영 on 2021/10/28.
//

import Foundation

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

