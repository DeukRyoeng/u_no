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

class SettingViewModel {
    
    let itemSelected = PublishRelay<SettingItem>()
    
    let items: Observable<[SettingItem]>
    let selection: Observable<SettingItem>
    let openURL: Observable<URL?>
    
    let actionTrigger: Observable<SettingAction>
    
    enum SettingAction {
        case accountDeletion
        case logout
        case showPeopleController
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
        
        actionTrigger = selection
            .compactMap { item -> SettingAction? in
                switch item.title {
                case "계정탈퇴":
                    return .accountDeletion
                case "로그아웃":
                    return .logout
                case "만든 사람":
                    return .showPeopleController
                default:
                    return nil
                }
            }
    }
}
