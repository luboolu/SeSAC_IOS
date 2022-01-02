//
//  SignInViewModel.swift
//  SeSAC_FARM
//
//  Created by 김진영 on 2022/01/02.
//

import Foundation

class SignInViewModel {
    
    var identifier: Observable<String> = Observable("")
    var password: Observable<String> = Observable("")
    
    func signIn(completion: @escaping () -> Void) {
        print("sign in api start")
        
        APIService.signIn(identifier: identifier.value, password: password.value) { data, error, usererror in
            print(data)
            print(error)
            
            if let usererror = usererror {
                print(usererror.message[0].messages[0].message)
            }
            
            completion()
        }
    }
    
}

