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
    let top3FallingPirces = BehaviorSubject<[Price]>(value: [])
    
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
                
                let sortedByRate = pricesWithRates.sorted {
                    (Double($0.value.asString()) ?? 0.0) > (Double($1.value.asString()) ?? 0.0)
                }
                
                print("Sorted Prices: \(sortedByRate)")
                
                let risingPrices = sortedByRate.filter { Double($0.value.asString()) ?? 0 > 0 }
                let top3Rising = Array(risingPrices.prefix(3))
                self?.top3RisingPrices.onNext(top3Rising)
                
                let pricesWithDrops: [(Price, Double)] = sortedByRate.compactMap { price in
                    guard let currentPrice = Double(price.dpr1.asString()) else { return nil }
                    
                    let previousPrices: [Double] = [
                        Double(price.dpr2.asString()),
                        Double(price.dpr3.asString()),
                        Double(price.dpr4.asString())
                    ].compactMap { $0 }

                    let maxDrop = previousPrices.map { previousPrice in
                        return previousPrice - currentPrice
                    }.max()

                    if let maxDrop = maxDrop, maxDrop > 0 {
                        return (price, maxDrop)
                    }
                    return nil
                }

                // 최대 하락폭으로 정렬 후 상위 3개 선택
                let top3Falling: [Price] = pricesWithDrops.sorted(by: { $0.1 > $1.1 }).prefix(3).map { $0.0 }

                // 결과를 Subject에 전달
                self?.top3FallingPirces.onNext(Array(top3Falling))



                // Print filtered falling prices for debugging
                print("Top 3 Falling Prices: \(top3Falling)")
                
            }, onFailure: { error in
                print("called ERROR MainViewModel: \(error)")
            }).disposed(by: disposeBag)
    }

    // Provide top 3 prices (always rising prices)
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
