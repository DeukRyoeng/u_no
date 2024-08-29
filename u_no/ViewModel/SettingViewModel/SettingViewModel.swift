//
//  SettingViewModel.swift
//  u_no
//
//  Created by t2023-m0117 on 8/29/24.
//

import RxSwift
import RxCocoa

class SettingViewModel {
    
    // Input
    let itemSelected = PublishRelay<SettingItem>()
    
    // Output
    let items: Observable<[SettingItem]>
    let selection: Observable<SettingItem>
    
    private let disposeBag = DisposeBag()
    
    init() {
        // Sample data
        let sampleItems = [
            SettingItem(title: "계정설정", hasSwitch: false),
            SettingItem(title: "알람", hasSwitch: true),
            SettingItem(title: "문의사항", hasSwitch: false),
            SettingItem(title: "로그아웃", hasSwitch: false),
            SettingItem(title: "계정탈퇴", hasSwitch: false)
        ]
        
        items = Observable.just(sampleItems)
        
        selection = itemSelected.asObservable()
    }
}

