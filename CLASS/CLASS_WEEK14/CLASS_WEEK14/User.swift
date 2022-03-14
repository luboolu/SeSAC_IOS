//
//  User.swift
//  CLASS_WEEK14
//
//  Created by 김진영 on 2021/12/27.
//

import Foundation
//MODEL
// MARK: - User
struct User: Codable {
    let jwt: String
    let user: UserClass
}

// MARK: - UserClass
struct UserClass: Codable {
    let id: Int
    let username, email: String
}
