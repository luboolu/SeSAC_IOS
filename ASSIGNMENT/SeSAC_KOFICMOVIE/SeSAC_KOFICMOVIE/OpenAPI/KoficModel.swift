//
//  KoficModel.swift
//  SeSAC_KOFICMOVIE
//
//  Created by 김진영 on 2021/11/02.
//

import Foundation

struct DaliyBoxoffice {
    let boxofficeType: String   //박스오피스 종류
    let showRange: String       //박스오피스 조회 일자
    let rnum: String            //순번
    let rank: String            //해당 일자의 박스오피스 순위
    let rankInten: String       //전일 대비 순위 증감
    let rankOldAndNew: String   //랭킹 신규진입여부
    let movieCD: String         //영화 대표코드
    let movieNm: String         //영화명(국문)
    let openDt: String          //영화 개봉일
    let salesAmt: String        //해당일의 매출액
    let salesShare: String      //상영작의 매출총액 대비 해당 영화의 매출 비율
    let salesChange: String     //전일 대비 매출액 증감 비율
    let salesAcc: String        //누적 매출액
    let audiCnt: String         //해당일의 관객수
    let audiIntenL: String      //전일 대비 관객수 증감분
    let audiChange: String      //전일 대비 관객수 증감 비율
    let audiAcc: String         //누적관객수
    let scrnCnt: String         //해당일자에 상영한 스크린수
    let showCnt: String         //해당일자에 상영된 횟수
}
