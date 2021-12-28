//
//  SignUpViewModel.swift
//  CLASS_WEEK14
//
//  Created by 김진영 on 2021/12/27.
//

import Foundation
import UIKit

class SignUpViewModel {

    var username: Observable<String> = Observable("")
    var email: Observable<String> = Observable("")
    var password: Observable<String> = Observable("")
    
    func postUserRegister(completion: @escaping () -> Void) {
        
        APIService.signUp(username: username.value, email: email.value, password: password.value) { userData, error in
            
            guard let userData = userData else {
                return
            }
            
            print(userData)
            print(error)
            
            completion()
            


        }
        
    }
    
}
