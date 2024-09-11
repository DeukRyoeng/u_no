//
//  LoginViewController.swift
//  u_no
//
//  Created by 이득령 on 9/10/24.
//

import UIKit
import FirebaseAuth
import SwiftUI

class LoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print("called LoginViewcontroller - RunApp")
        view.backgroundColor = .white
        
        setupUI()
    }
}
extension LoginViewController {
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
}
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
