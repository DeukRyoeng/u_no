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
    let graphPrice = BehaviorSubject(value: [PriceInfo]())
    
    func fetchData(strtDay: String, endDay: String, itemCode: String) {
        let endpoint = Endpoint(
            baseURL: "https://www.kamis.or.kr",
            path: "/service/price/xml.do",
            queryParameters: [
                "p_cert_key": "5845f7c3-4274-41a7-a88a-c79efefe21dc",
                "action": "periodProductList",
                "p_cert_id": "4710",
                "p_returntype": "json",
                "p_startday": strtDay,
                "p_endday": endDay,
                "p_productclscode": "01",//소매01, 도매02
                "p_itemcode": itemCode,//필수
                "p_countrycode": "1101",
                "p_convert_kg_yn": "Y"
            ])
        
        network.fetch(endpoint: endpoint)
            .subscribe(onSuccess: { [weak self] (result: GraphPrice) in
                print("+++called SUCCESS MainViewModel+++")
                self?.graphPrice.onNext(result.data.item)
            }, onFailure: {error in
                print("called ERROR MainViewmodel: \(error)")
            }
            ).disposed(by: disposeBag)
    }
    
}
