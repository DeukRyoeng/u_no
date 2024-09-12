//
//  LoginViewController.swift
//  u_no
//
//  Created by 이득령 on 9/10/24.
//

import UIKit
import CryptoKit
import FirebaseAuth
import SwiftUI
import AuthenticationServices

class LoginViewController: UIViewController {
    
    fileprivate var currentNonce: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("called LoginViewcontroller - RunApp")
        view.backgroundColor = .white
        setupUI()
        
    }
}

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
        
        let signUpButton = UIButton()
        signUpButton.setTitle("아직 회원이 아니신가요? 회원가입 하러가기.", for: .normal)
        signUpButton.titleLabel?.numberOfLines = 0
        signUpButton.titleLabel?.textAlignment = .center
        signUpButton.setTitleColor(.black, for: .normal)
        
        signUpButton.titleLabel?.layer.shadowColor = UIColor.black.cgColor // 그림자 색상
        signUpButton.titleLabel?.layer.shadowOffset = CGSize(width: 8, height: 8) // 그림자의 위치 (x, y)
        signUpButton.titleLabel?.layer.shadowRadius = 3 // 그림자 반경 (흐림 정도)
        signUpButton.titleLabel?.layer.shadowOpacity = 0.15 // 그림자 투명도 (0~1)
        view.addSubview(mainLogoImage)
        view.addSubview(applebutton)
        view.addSubview(kakaobutton)
        view.addSubview(signUpButton)
        
        applebutton.addTarget(self, action: #selector(appleSignInBtn), for: .touchUpInside)
        
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
            $0.bottom.equalTo(signUpButton.snp.top).offset(-40)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(48)
            $0.width.equalTo(320)
            
        }
        
        signUpButton.snp.makeConstraints {
            $0.bottom.equalTo(20)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    @objc func appleSignInBtn() {
        print("clicked Apple SignIn Button")
        startSignInApple()
    }
}

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
            // 사용자의 전체 이름을 포함한 Firebase 자격 증명을 초기화합니다.
            let credential = OAuthProvider.appleCredential(withIDToken: idTokenString, rawNonce: nonce, fullName: appleIDcredential.fullName)
            
            // Firebase에 로그인하기.
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Apple Signin Error: \(error.localizedDescription)")
                    return
                }
                //로그인에 성공했을 시 실행할 메서드
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
