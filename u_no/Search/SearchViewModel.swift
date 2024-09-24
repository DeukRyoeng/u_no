//
//  SearchViewModel.swift
//  u_no
//
//  Created by 이득령 on 9/6/24.
//

import Foundation
import RxSwift


class SearchViewModel {
    private let disposeBag = DisposeBag()
    
    let network = NetworkManager.shared
    let priceAllInfo = PublishSubject<[Price]>()
    // 검색 쿼리
    let searchQuery = PublishSubject<String>()
    // 필터링된 가격 정보
    let filteredPrices: Observable<[Price]>
    
    init() {
        filteredPrices = Observable.combineLatest(priceAllInfo, searchQuery) { prices, query in
            let retailPrices = prices.filter { $0.productClsCode == "01" && $0.categoryCode != "500"}
            return retailPrices.filter { price in
                price.itemName?.lowercased().contains(query.lowercased()) ?? false
            }
        }
    }
    
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
                self?.priceAllInfo.onNext(result.price)
            }, onFailure: { error in
                print("called ERROR SearchViewModel: \(error)")
            }).disposed(by: disposeBag)
    }
}
