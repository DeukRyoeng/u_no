//
//  Common.swift
//  u_no
//
//  Created by 백시훈 on 9/10/24.
//

import Foundation
import UIKit
class Common{
    func showAlert(viewController: UIViewController, message: String){
        let alert = UIAlertController(title: "확인", message: "\(message)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
