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
    let searchData = BehaviorSubject<[Item]>(value: [])
    
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
            }, onFailure: {error in
                print("called ERROR MainViewmodel: \(error)")
            }).disposed(by: disposeBag)
    }
    ///API 원하는 상품 불러오기
    func fetchSearchData() {
        let endpoint = Endpoint (
            baseURL: "https://www.kamis.or.kr",
            path: "/service/price/xml.do",
            queryParameters: [
                "action": "periodProductList",
                "p_cert_key": "5845f7c3-4274-41a7-a88a-c79efefe21dc",
                "p_cert_id": "4710",
                "p_productclscode": "01", // 소매, 도매 구분 ( 01:소매, 02:도매, default:02)
                "p_itemcategorycode": "200", // 부류 관리
                "p_itemcode": "212", // 품목 코드
                "p_kindcode": "00", //품종 코드
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
