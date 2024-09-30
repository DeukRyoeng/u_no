//
//  LaunchViewController.swift
//  u_no
//
//  Created by t2023-m0117 on 9/30/24.
//

import UIKit
import SnapKit

class LaunchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.mainGreen
        
        let imageView = UIImageView(image: UIImage(named: "Launch"))
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { [weak self] in
            self?.switchTabbarController()
        }
    }
    
    private func switchTabbarController() {
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate {
            let tabbarController = TabbarController()
            sceneDelegate.window?.rootViewController = tabbarController
            
            UIView.transition(with: sceneDelegate.window!,
                              duration: 0.5,
                              animations: nil,
                              completion: nil)
        }
    }
}
