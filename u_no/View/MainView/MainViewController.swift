//
//  MainViewController.swift
//  u_no
//
//  Created by 이득령 on 8/29/24.
//

import Foundation
import UIKit
import RxSwift

class MainViewController: UIViewController {
    
    let mainVM = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("+++called MainViewController : Run App+++")
        
//        mainVM.fetchAllprices()
//        bindPriceData()
    
    }
    
}

extension MainViewController {
    
//    func bindPriceData() {
//        mainVM.foodPriceDataSubject.observe(on: MainScheduler.instance).subscribe(onNext: {
//            [weak self] data in
//            print("+++called MainViewController+++")
//            print(data)
//        }, onError: { error in
//            print("--- called MainViewController ERROR ---")
//            print("\(error)")
//        }
//        )
//    }
}
