//
//  Error.swift
//  SeSAC_FARM
//
//  Created by 김진영 on 2022/01/01.
//

import Foundation
//
// MARK: - Error
struct UserError: Codable {
    let statusCode: Int
    let error: String
    let message, data: [UserDatum]
}

// MARK: - Datum
struct UserDatum: Codable {
    let messages: [UserMessage]
}

// MARK: - Message
struct UserMessage: Codable {
    let id, message: String
}
