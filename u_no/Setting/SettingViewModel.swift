//
//  SettingViewModel.swift
//  u_no
//
//  Created by t2023-m0117 on 8/29/24.
//

import RxSwift
import RxCocoa
import Foundation
import UIKit
import RxKakaoSDKAuth
import RxKakaoSDKUser
import KakaoSDKAuth
import KakaoSDKUser
class SettingViewModel {
    
    let itemSelected = PublishRelay<SettingItem>()
    let accountVM = AccountVM.shared
    let items: Observable<[SettingItem]>
    let selection: Observable<SettingItem>
    let openURL: Observable<URL?>
    
    // New observable for actions like logout or account deletion
    let actionTrigger: Observable<SettingAction>
    
    enum SettingAction {
        case accountDeletion
        case logout
    }

    private let disposeBag = DisposeBag()
    
    init() {
        let sampleItems = [
            SettingItem(title: "만든 사람", hasSwitch: false, titleColor: .black),
            SettingItem(title: "알림", hasSwitch: true, titleColor: .black),
            SettingItem(title: "문의사항", hasSwitch: false, titleColor: .black),
            SettingItem(title: "로그아웃", hasSwitch: false, titleColor: .black),
            SettingItem(title: "계정탈퇴", hasSwitch: false, titleColor: UIColor.mainRed)
        ]
        
        items = Observable.just(sampleItems)
        
        selection = itemSelected.asObservable()

        openURL = selection.map { item in
            if item.title == "문의사항" {
                return URL(string: "https://www.notion.so/a43bd4b54a4a4fee8d8e2530b15a2359")
            } else {
                return nil
            }
        }
        
        // New mapping for logout and account deletion actions
        actionTrigger = selection
            .compactMap { item -> SettingAction? in
                if item.title == "계정탈퇴" {
                    return .accountDeletion
                } else if item.title == "로그아웃" {
                    return .logout
                }
                return nil
            }
    }
    //카카오서비스 로그아웃 메서드입니다.
    func startKakaoSignOut() {
        UserApi.shared.rx.logout()
            .subscribe(onCompleted:{
                print("logout() success.")
                self.accountVM.gotoLoginVC()
            }, onError: {error in
                print(error)
            })
            .disposed(by: disposeBag)

    }
    
}
