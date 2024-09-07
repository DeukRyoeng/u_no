//
//  MainVM.swift
//  u_no
//
//  Created by 이득령 on 8/29/24.
//

import RxDataSources
import RxSwift
import RxCocoa

class MainViewModel {
    
    private let disposeBag = DisposeBag()
    
    
    let network = NetworkManager.shared
    
    let foodPrices = BehaviorSubject<[Price]>(value: [])
    let top3Prices = BehaviorSubject<[Price]>(value: []) // 등락률이 높은 상위 3개 품목을 저장하는 subject
    
    /// API 전체데이터 불러오기
    func fetchAllData() {
        let endpoint = Endpoint(
            baseURL: "https://www.kamis.or.kr",
            path: "/service/price/xml.do",
            queryParameters: [
                "p_cert_key": "5845f7c3-4274-41a7-a88a-c79efefe21dc",
                "action": "dailySalesList",
                "p_cert_id": "4710",
                "p_returntype": "json"
            ])
        network.fetch(endpoint: endpoint)
            .subscribe(onSuccess: { [weak self] (result: Foodprices) in
                print("+++called SUCCESS MainViewModel+++")
                self?.foodPrices.onNext(result.price)
                
                // 등락률이 높은 상위 3개 품목만 필터링
                let sortedPrices = result.price.sorted { price1, price2 in
                    let value1 = Double(price1.value.asString()) ?? 0.0
                    let value2 = Double(price2.value.asString()) ?? 0.0
                    return value1 > value2
                }
                // 상위 3개 품목만 top3prices 에 넣음
                let top3 = Array(sortedPrices.prefix(3))
                self?.top3Prices.onNext(top3)
                
            }, onFailure: {error in
                print("called ERROR MainViewmodel: \(error)")
            }).disposed(by: disposeBag)
    }
  
    
    
}
