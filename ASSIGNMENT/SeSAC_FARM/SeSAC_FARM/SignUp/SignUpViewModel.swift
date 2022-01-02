//
//  SignUpViewModel.swift
//  SeSAC_FARM
//
//  Created by 김진영 on 2022/01/01.
//

import Foundation

class SignUpViewModel {
    
    var nickname: Observable<String> = Observable("")
    var email: Observable<String> = Observable("")
    var password: Observable<String> = Observable("")
    var passwordConfirm: Observable<String> = Observable("")
    
    func signUp(completion: @escaping () -> Void) {
        print("sign up api start")
        
        APIService.signUp(username: nickname.value, email: email.value, password: password.value) { data, error, signerror in
            print(data)
            print(error)
            
            if let signerror = signerror {
                print(signerror.message[0].messages[0].message)
            }
            
            completion()
        }
    }
    
}
