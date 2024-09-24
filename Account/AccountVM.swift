//
//  AccountVM.swift
//  u_no
//
//  Created by 이득령 on 9/20/24.
//

import UIKit
import FirebaseAuth
import Firebase
import RxSwift
import RxKakaoSDKAuth
import RxKakaoSDKUser
import KakaoSDKUser

enum AccountType {
    case kakao
    case apple
}


class AccountVM {
    static let shared = AccountVM()
    private init() {}
    
    private let disposeBag = DisposeBag()
    
    /// Firebase 로그아웃 메서드입니다
    func startAppleSignOut() {
        let firebase = Auth.auth()
        do {
            try firebase.signOut()
            self.gotoLoginVC()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    ///카카오서비스 로그아웃 메서드입니다.
    func startKakaoSignOut() {
        UserApi.shared.rx.logout()
            .subscribe(onCompleted:{
                print("logout() success.")
                self.gotoLoginVC()
            }, onError: {error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    ///현재 로그인 되어 있는 계저엥 맞게 로그아웃을 진행합니다.
    func accountTypeCheck() {
        var accountType = UserDefaults.standard.string(forKey: "AccountType")
        
        if accountType == "kakao" {
            startKakaoSignOut()
        }
        else if accountType == "apple" {
            startAppleSignOut()
        }
    }
    
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
    
    ///Apple SignIn 탈퇴 메서드입니다.
    func removeAccount() {

      let token = UserDefaults.standard.string(forKey: "refreshToken")
      if let token = token {
          let url = URL(string: "https://us-central1-youknow-9a146.cloudfunctions.net/revokeToken?refresh_token=\(token)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "https://apple.com")!
          let task = URLSession.shared.dataTask(with: url) {(data, response, error) in

            guard data != nil else { return }
          }
          task.resume()
      }
        do {
            print("로그아웃 성공")
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)

        }

    }
          

}
