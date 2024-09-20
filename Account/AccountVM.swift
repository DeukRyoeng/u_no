//
//  AccountVM.swift
//  u_no
//
//  Created by 이득령 on 9/20/24.
//

import UIKit

class AccountVM {
    static let shared = AccountVM()
    private init() {}
    
    /// 로그인뷰로 가는 메서드입니다.
    func gotoLoginVC() {
        // MainViewController 인스턴스 생성
        let loginVC = LoginViewController()
        
        // 윈도우 객체 가져오기
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            
            // 루트 ViewController를 MainViewController로 교체
            window.rootViewController = loginVC
            
            // 전환 애니메이션을 추가하려면 아래와 같이 설정 가능
            UIView.transition(with: window, duration: 0.5, options: .allowAnimatedContent, animations: nil, completion: nil)
            
            // 화면 보이기
            window.makeKeyAndVisible()
        }
    }
    ///메인화면으로 가는 메서드입니다.
    func gotoMainVC() {
        let tabbarVC = TabbarController()
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            
            // 루트 ViewController를 MainViewController로 교체
            window.rootViewController = tabbarVC
            
            // 전환 애니메이션을 추가하려면 아래와 같이 설정 가능
            UIView.transition(with: window, duration: 0.5, options: .allowAnimatedContent, animations: nil, completion: nil)
            
            // 화면 보이기
            window.makeKeyAndVisible()
        }
    }

}
