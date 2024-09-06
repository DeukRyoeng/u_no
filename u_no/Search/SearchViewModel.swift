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

    let searchData = BehaviorSubject<[Item]>(value: [])
    
    ///API 원하는 상품 불러오기
    func fetchSearchData(itemcategory: String, itemcode: String, kindcode: String) {
        let endpoint = Endpoint (
            baseURL: "https://www.kamis.or.kr",
            path: "/service/price/xml.do",
            queryParameters: [
                "action": "periodProductList",
                "p_cert_key": "5845f7c3-4274-41a7-a88a-c79efefe21dc",
                "p_cert_id": "4710",
                "p_productclscode": "01", // 소매, 도매 구분 ( 01:소매, 02:도매, default:02)
                "p_itemcategorycode": "\(itemcategory)", // 부류 관리
                "p_itemcode": "\(itemcode)", // 품목 코드
                "p_kindcode": "\(kindcode)", //품종 코드
                "p_convert_kg_yn": "Y",//KG 환산 여부
                "p_startday": "2024-09-05", // 조회 시작 날짜
                "p_endday": "2024-09-05", // 조회 마감 날짜
                "p_returntype": "json"
            ])
        network.fetch(endpoint: endpoint)
            .subscribe(onSuccess: { [weak self] (result: SearchData) in
                print("+++called SUCCESS MainViewModel+++")
                self?.searchData.onNext(result.data.item)
            }, onFailure: {error in
                print("clled ERROR MainVM SearchFetch failed :\(error)")
            }).disposed(by: disposeBag)
    }

}
