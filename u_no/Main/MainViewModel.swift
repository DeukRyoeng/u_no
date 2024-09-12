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
    let top3RisingPrices = BehaviorSubject<[Price]>(value: []) // 등락률이 높은 상위 3개 품목을 저장하는 subject
    let top3FallingPirces = BehaviorSubject<[Price]>(value: []) // 등락률이 낮은 상위 3개 품목을 저장하는 subject
    let isRising = BehaviorSubject<Bool>(value: true) // 토글 스위치 
    
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
                
                // 가격 비교 및 등락률 수정
                let updatedPrices = result.price.map { price -> Price in
                    let dpr1 = Double(price.dpr1.asString()) ?? 0.0
                    let dpr2 = Double(price.dpr2.asString()) ?? 0.0
                    
                    let abjustdValue = dpr1 > dpr2 ? price.value.asString() : "-\(price.value.asString())"
                    return price.updatedValue(newValue: abjustdValue)
                }
                
                // 등락률 기준으로 데이터를 필터링 및 정렬
                let sortedPrices = updatedPrices.sorted {
                    (Double($0.value.asString()) ?? 0) > (Double($1.value.asString()) ?? 0)
                }
                    
                // 상승한 품목: 등락률이 양수인 품목만 필터링 하고 상위 3개 추출
                let risingPrices = sortedPrices
                    .filter { Double($0.value.asString()) ?? 0 > 0 }
                    .sorted { Double($0.value.asString()) ?? 0 > Double($1.value.asString()) ?? 0 }
                let top3Rising = Array(risingPrices.prefix(3))
                self?.top3RisingPrices.onNext(top3Rising)
                
                // 하락한 품목: 등락률이 음수인 품목만 필터링 하고 상위 3개 추출
                let fallingPrices = sortedPrices
                    .filter { Double($0.value.asString()) ?? 0 < 0 }
                    .sorted { Double($0.value.asString()) ?? 0 > Double($1.value.asString()) ?? 0 }
                let top3Falling = Array(fallingPrices.prefix(3))
                self?.top3FallingPirces.onNext(top3Falling)
                
            }, onFailure: {error in
                print("called ERROR MainViewmodel: \(error)")
            }).disposed(by: disposeBag)
    }
    
    // 선택한 시세 데이터 전달(스위치 토글 상태에 따라 상승/하락 데이터 제공)
    var currentTop3Prices: Observable<[Price]> {
        return isRising
            .flatMapLatest { isRising -> Observable<[Price]> in
                return isRising ? self.top3RisingPrices : self.top3FallingPirces
            }
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
            value: newValue != nil ? .string(newValue!) : self.value // 새로운 값 있으면 업데이트
        )
    }
}
