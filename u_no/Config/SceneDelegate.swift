//
//  SceneDelegate.swift
//  u_no
//
//  Created by 이득령 on 8/29/24.
//

import UIKit

import RxKakaoSDKAuth
import RxKakaoSDKUser
import KakaoSDKUser
import KakaoSDKAuth
import RxKakaoSDKCommon
import AuthenticationServices
import RxSwift


class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    let disposeBag = DisposeBag()
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        // Apple과 Kakao 로그인 상태를 확인할 DispatchGroup
           let group = DispatchGroup()
           var isAppleLoggedIn = false
           var isKakaoLoggedIn = false
           // 비동기적으로 작동함
           group.enter()
           checkAppleSignInState { isLoggedIn in
               isAppleLoggedIn = isLoggedIn
               group.leave()
           }
           
           group.enter()
           checkKakaoSignInState { isLoggedIn in
               isKakaoLoggedIn = isLoggedIn
               group.leave()
           }
           
           group.notify(queue: .main) {
               if isAppleLoggedIn || isKakaoLoggedIn {
                   // 둘 중 하나라도 로그인된 상태라면 메인 화면 (TabbarController) 설정
                   window.rootViewController = TabbarController()
               } else {
                   // 로그인되지 않았을 경우 로그인 화면 설정
                   window.rootViewController = LoginViewController()
               }
               window.makeKeyAndVisible()
               self.window = window
           }
    }
    
    func checkAppleSignInState(completion: @escaping (Bool) -> Void) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        
        // 저장된 사용자 ID 가져오기
        if let userIdentifier = UserDefaults.standard.string(forKey: "appleUserIdentifier") {
            
            // Apple ID 상태 확인
            appleIDProvider.getCredentialState(forUserID: userIdentifier) { credentialState, error in
                switch credentialState {
                case .authorized:
                    print("Apple ID 로그인 세션 유효")
                    completion(true) // 로그인된 상태
                case .revoked, .notFound:
                    print("Apple ID 로그인 세션 만료 또는 자격 없음")
                    completion(false) // 로그인되지 않은 상태
                default:
                    completion(false)
                }
            }
        } else {
            // 사용자 ID가 없으면 로그인되지 않은 상태로 처리
            completion(false)
        }
    }
    
    func checkKakaoSignInState(completion: @escaping(Bool) -> Void) {
        if (AuthApi.hasToken()) {
            UserApi.shared.rx.accessTokenInfo()
                .subscribe(onSuccess: { (_) in
                    // 토큰 유효
                    completion(true)
                }, onFailure: { error in
                   print(error)
                    completion(false)
                } ).disposed(by: disposeBag)
        }
        
    }
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        if let url = URLContexts.first?.url {
            if (AuthApi.isKakaoTalkLoginUrl(url)) {
                _ = AuthController.rx.handleOpenUrl(url: url)
            }
        }
    }
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}

