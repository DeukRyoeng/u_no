
//
//  GraphViewModel.swift
//  u_no
//
//  Created by 백시훈 on 9/5/24.
//

import Foundation
import RxDataSources
import RxSwift
import RxCocoa
class GraphViewModel{
    private let disposeBag = DisposeBag()
    let network = NetworkManager.shared
    let graphPrice = BehaviorSubject(value: [PriceData]())
    
    func fetchData(regday: String, productNo: String) {
        let endpoint = Endpoint(
            baseURL: "https://www.kamis.or.kr",
            path: "/service/price/xml.do",
            queryParameters: [
                "p_cert_key": "5845f7c3-4274-41a7-a88a-c79efefe21dc",
                "action": "recentlyPriceTrendList",
                "p_cert_id": "4710",
                "p_returntype": "json",
                "p_regday": regday,
                "p_productno": productNo
            ])
        
        network.fetch(endpoint: endpoint)
            .subscribe(onSuccess: { [weak self] (result: GraphPrice) in
                print("+++called SUCCESS GraphViewModel+++")
                self?.graphPrice.onNext(result.price)
            }, onFailure: {error in
                print("called ERROR GraphViewModel: \(error)")
            }
            ).disposed(by: disposeBag)
    }
    
}
