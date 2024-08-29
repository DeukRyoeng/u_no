//
//  SettingViewModel.swift
//  u_no
//
//  Created by t2023-m0117 on 8/29/24.
//

import RxSwift
import RxCocoa
import Foundation

class SettingViewModel {
    
    let itemSelected = PublishRelay<SettingItem>()
    
    let items: Observable<[SettingItem]>
    let selection: Observable<SettingItem>
    let openURL: Observable<URL?>

    private let disposeBag = DisposeBag()
    
    init() {
        let sampleItems = [
            SettingItem(title: "계정설정", hasSwitch: false),
            SettingItem(title: "알람", hasSwitch: true),
            SettingItem(title: "문의사항", hasSwitch: false),
            SettingItem(title: "로그아웃", hasSwitch: false),
            SettingItem(title: "계정탈퇴", hasSwitch: false)
        ]
        
        items = Observable.just(sampleItems)
        
        selection = itemSelected.asObservable()

        openURL = selection.map { item in
            if item.title == "문의사항" {
                return URL(string: "https://www.naver.com")
            } else {
                return nil
            }
        }
    }
}
