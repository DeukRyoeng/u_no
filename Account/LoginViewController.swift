//
//  LoginViewController.swift
//  u_no
//


//  Created by 이득령 on 9/10/24.
//

import UIKit
import RxSwift
import CryptoKit
import FirebaseAuth
import SwiftUI
import AuthenticationServices
import RxKakaoSDKAuth
import KakaoSDKAuth
import RxKakaoSDKUser
import KakaoSDKUser
import Alamofire

class LoginViewController: UIViewController {
    
    fileprivate var currentNonce: String?
    let disposeBag = DisposeBag()
    let acccountVM = AccountVM.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("called LoginViewcontroller - RunApp")
        view.backgroundColor = .white
        setupUI()
        //checkAuthState()

    }
}

extension LoginViewController {
    
    /// 현재 로그인 상태를 체크하는 메서드.
    func checkAuthState() {
        if let user = Auth.auth().currentUser {
            // 사용자가 로그인되어 있을 때 처리할 동작
            print("사용자 로그인 됨 UID\(user.uid)")
            
        } else {
            print("사용자가 로그인하지 않음.")
                acccountVM.gotoLoginVC()
        }
        
        if (AuthApi.hasToken()) {
            UserApi.shared.rx.accessTokenInfo()
                .subscribe(onSuccess: {(token) in
                    //토크 유효성 체크 성공 필요시 갱신
                    print("유효성 체크 완료:\(token.id)")
                }, onFailure: { error in
                    print(error)
                })
                .disposed(by: disposeBag)
            
        } else {
            //로그인 필요
            acccountVM.gotoLoginVC()
            
            
        }
        
        //로그인 상태변경를 감지함
        //        Auth.auth().addStateDidChangeListener { (auth, user) in
        //            if let user = user {
        //                //사용자가 로그인한 상태일때
        //                print("사용자 로그인 됨 UID\(user.uid)")
        //                // MainView로 넘어가는 메서드 추가
        //            } else {
        //                print("사용자가 로그인하지 않음.")
        //                // LoginView로 넘어가는 메서드 추가
        //
        //            }
        //        }
    }
  
    
}

//MARK: - UI
extension LoginViewController {
    //MARK: - UI관련 메서드
    private func setupUI() {
        let mainLogoImage = UIImageView()
        mainLogoImage.image = UIImage(named: "mainTitle")
        mainLogoImage.contentMode = .scaleAspectFit
        
        let applebutton = UIButton()
        applebutton.setImage(UIImage(named: "applebtn"), for: .normal)
        applebutton.imageView?.contentMode = .scaleAspectFit
        
        let kakaobutton = UIButton()
        kakaobutton.setImage(UIImage(named: "kakaobtn"), for: .normal)
        kakaobutton.imageView?.contentMode = .scaleAspectFit
        
        view.addSubview(mainLogoImage)
        view.addSubview(applebutton)
        view.addSubview(kakaobutton)
        
        applebutton.addTarget(self, action: #selector(appleSignInBtn), for: .touchUpInside)
        kakaobutton.addTarget(self, action: #selector(kakaoSignInBtn), for: .touchUpInside)
        
        mainLogoImage.snp.makeConstraints {
            $0.top.equalTo(40)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(350)
            $0.width.equalTo(350)
        }
        
        applebutton.snp.makeConstraints {
            $0.bottom.equalTo(kakaobutton.snp.top).offset(-20)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(48)
            $0.width.equalTo(320)
            
        }
        
        kakaobutton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-40)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(48)
            $0.width.equalTo(320)
            
        }
        
   
    }
    
    @objc func appleSignInBtn() {
        print("clicked Apple SignIn Button")
        startSignInApple()
    }
    
    @objc func kakaoSignInBtn() {
        print("clicked Kakao SignIn Button")
        startSignInKakao()
    }
}

//MARK: - SignIn With Kakao
private extension LoginViewController {
    
    func startSignInKakao() {
        // 카카오톡 실행 가능 여부 체크
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.rx.loginWithKakaoTalk()
                .subscribe(onNext: { (oauthToken) in
                    print("loginWithKakaoTalk() success.")
                    UserDefaults.standard.set("kakao", forKey: "AccountType")
                    self.acccountVM.gotoMainVC()
                }, onError: { error in
                    print("Kakao Login error: \(error)")
                })
                .disposed(by: disposeBag)
        } else {
            //카카오톡 실행 안됨
            UserApi.shared.rx.loginWithKakaoAccount()
                .subscribe(onNext:{ (oauthToken) in
                    print("loginWithKakaoAccount() success.")
                    UserDefaults.standard.set("kakao", forKey: "AccountType")
                    self.acccountVM.gotoMainVC()
                    _ = oauthToken
                }, onError: {error in
                    print(error)
                })
                .disposed(by: disposeBag)
        }
    }
}

//MARK: - SignIn With Apple
private extension LoginViewController {
    
    func startSignInApple() {
        let nonce = randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [ .fullName, .email]
        request.nonce = sha256(nonce)
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()    }
    
    @available(iOS 13, *)
    func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        var randomBytes = [UInt8](repeating: 0, count: length)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        if errorCode != errSecSuccess {
            fatalError(
                "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
            )
        }
        let charset: [Character] =         Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        let nonce = randomBytes.map { byte in
            // 필요한 경우 세트에서 무작위로 캐릭터를 선택하여 랩을 감음
            charset[Int(byte) % charset.count]
        }
        return String(nonce)
    }
    
    func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        return hashString
    }
}
extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        if let appleIDcredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: 로그인 콜백이 수신되었지만 로그인 요청이 전송되지 않았습니다.")
            }
            guard let appleIDToken = appleIDcredential.identityToken else {
                print("식별토큰을 가져올 수 없습니다.")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("데이터에서 토큰 문자열을 직렬화 할 수 없음: \(appleIDToken.debugDescription)")
                return
            }
            if let authorizationCode = appleIDcredential.authorizationCode, let codeString = String(data: authorizationCode, encoding: .utf8) {
                  let url = URL(string: "https://us-central1-youknow-9a146.cloudfunctions.net/getRefreshToken?code=\(codeString)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "https://apple.com")!
                //https://us-central1-youknow-9a146.cloudfunctions.net/getRefreshToken

                        
                    let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                        
                        if let data = data {
                            let refreshToken = String(data: data, encoding: .utf8) ?? ""
                            print(refreshToken)
                            UserDefaults.standard.set(refreshToken, forKey: "refreshToken")
                            UserDefaults.standard.synchronize()
                        }
                    }
                  task.resume()
                  
              }
            // 사용자의 전체 이름을 포함한 Firebase 자격 증명을 초기화합니다.
            let credential = OAuthProvider.appleCredential(withIDToken: idTokenString, rawNonce: nonce, fullName: appleIDcredential.fullName)
            
            // Firebase에 로그인하기.
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Apple Signin Error: \(error.localizedDescription)")
                    return
                }
                //로그인에 성공했을 시 실행할 메서드

                let userIdentifier = appleIDcredential.user

                UserDefaults.standard.set(userIdentifier, forKey: "appleUserIdentifier")
                UserDefaults.standard.set("apple", forKey: "AccountType")
                self.acccountVM.gotoMainVC()
            }
        }
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: any Error) {
        // 에러 핸들링
        print("Sign in with Apple errored: \(error)")
    }
}
extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        // Apple 로그인 인증 창 띄우기
        return self.view.window ?? UIWindow()
    }
}

//MARK: - Preview

struct ViewControllerRepresentable: UIViewControllerRepresentable {
    typealias UIViewControllerType = LoginViewController
    
    func makeUIViewController(context: Context) -> LoginViewController {
        return LoginViewController()
    }
    
    func updateUIViewController(_ uiViewController: LoginViewController, context: Context) {
    }
}
@available(iOS 13.0.0, *)
struct ViewPreview: PreviewProvider {
    static var previews: some View {
        ViewControllerRepresentable()
    }
}
