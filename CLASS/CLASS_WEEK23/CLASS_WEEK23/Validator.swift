//
//  Validator.swift
//  CLASS_WEEK23
//
//  Created by 김진영 on 2022/03/02.
//

import Foundation

final class Validator {
    func isValidID(id: String?) -> Bool {
        guard let id = id else {
            return false
        }
        
        return id.contains("@") && id.count >= 6
    }
    
    func isValidPassword(password: String?) -> Bool {
        guard let password = password else {
            return false
        }
        
        return password.count >= 6 && password.count < 10
    }
    
    func isEqualPassword(password: String?, check: String?) -> Bool {
        guard let password = password, let check = check else {
            return false
        }
        
        return password == check
    }
}
