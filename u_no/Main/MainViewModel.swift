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
    let top3RisingPrices = BehaviorSubject<[Price]>(value: [])
    let top3FallingPrices = BehaviorSubject<[Price]>(value: [])
    
    /// Fetch all data from the API
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
                
                let pricesWithRates = result.price.map { price -> Price in
                    let rate = Double(price.value.asString()) ?? 0.0
                    return price.updatedValue(newValue: "\(rate)")
                }
                
                // 등락률이 상승한 가격
                let risingPrices = pricesWithRates.filter { $0.direction.asString() == "1" }
                let top3Rising = Array(risingPrices.sorted {
                    (Double($0.value.asString()) ?? 0.0) > (Double($1.value.asString()) ?? 0.0)
                }.prefix(3))
                self?.top3RisingPrices.onNext(top3Rising)

                // 등락률이 하락한 가격
                let fallingPrices = pricesWithRates.filter { $0.direction.asString() == "0" }

                let top3Falling = fallingPrices.sorted {
                    let firstRate = Double($0.value.asString()) ?? 0.0
                    let secondRate = Double($1.value.asString()) ?? 0.0
                    return firstRate > secondRate
                }.prefix(3)
                
                self?.top3FallingPrices.onNext(Array(top3Falling))
                
            }, onFailure: { error in
                print("called ERROR MainViewModel: \(error)")
            }).disposed(by: disposeBag)
    }

    var currentTop3Prices: Observable<[Price]> {
        return top3RisingPrices
    }
}

extension Price {
    func updatedValue(rate: Double? = nil, newValue: String? = nil) -> Price {
        return Price(
            productClsCode: self.productClsCode,
            productClsName: self.productClsName,
            categoryCode: self.categoryCode,
            categoryName: self.categoryName,
            productno: self.productno,
            lastestDay: self.lastestDay,
            productName: self.productName,
            itemName: self.itemName,
            unit: self.unit,
            day1: self.day1,
            dpr1: self.dpr1,
            day2: self.day2,
            dpr2: self.dpr2,
            day3: self.day3,
            dpr3: self.dpr3,
            day4: self.day4,
            dpr4: self.dpr4,
            direction: self.direction,
            value: newValue != nil ? .string(newValue!) : self.value
        )
    }
}
