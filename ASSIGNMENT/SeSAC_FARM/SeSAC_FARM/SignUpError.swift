//
//  Error.swift
//  SeSAC_FARM
//
//  Created by 김진영 on 2022/01/01.
//

import Foundation
//
// MARK: - Error
struct SignUpError: Codable {
    let statusCode: Int
    let error: String
    let message, data: [SignUpDatum]
}

// MARK: - Datum
struct SignUpDatum: Codable {
    let messages: [SignUpMessage]
}

// MARK: - Message
struct SignUpMessage: Codable {
    let id, message: String
}
