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
    
  
//https://www.kamis.or.kr/service/price/xml.do?p_cert_key=5845f7c3-4274-41a7-a88a-c79efefe21dc&action=dailySalesList&p_cert_id=4710&p_returntype=json
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
            }, onFailure: {error in
                print("called ERROR MainViewmodel: \(error)")
            }
            ).disposed(by: disposeBag)
    }
    
    
}
