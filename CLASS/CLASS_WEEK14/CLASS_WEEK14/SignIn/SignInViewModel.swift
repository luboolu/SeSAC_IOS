//
//  SignInViewModel.swift
//  CLASS_WEEK14
//
//  Created by 김진영 on 2021/12/27.
//

import Foundation
import UIKit

class SignInViewModel {

    var username: Observable<String> = Observable("")
    var password: Observable<String> = Observable("")
    
    func postUserLogin(completion: @escaping () -> Void) {
        
        APIService.login(identifier: username.value, password: password.value) { userData, error in
            
            guard let userData = userData else {
                return
            }
            
            //로그인을 성공했으면 토큰을 저장해줘야함!
            UserDefaults.standard.set(userData.jwt, forKey: "token")
            UserDefaults.standard.set(userData.user.username, forKey: "nickname")
            UserDefaults.standard.set(userData.user.id, forKey: "id")
            UserDefaults.standard.set(userData.user.email, forKey: "email")
            
            //로그인 성공 알림 띄우고, 메인 화면으로 화면 전환
            //여기서 단순이 present나 push가 아니라 root view 자체를 바꿔주는게 좋다 - 메모리에 불필요하게 남겨둘 필요가 없으므로
            //화면전환 부분은 뷰 컨트롤러에서 해줘야하므로 completion 실행(mvvm)
            completion()
            


        }
        
    }
    
}
