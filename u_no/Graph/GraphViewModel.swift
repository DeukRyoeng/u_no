
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
    
    let priceData = BehaviorRelay<[Double]>(value: [])
    let dateData = BehaviorRelay<[String]>(value: [])
    let tableData = BehaviorRelay<[[String]]>(value: [])
    let alertMessage = PublishSubject<String>()
    
    var baseData: [Price] = []
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
                self?.processingData(result.price.first!, regday: regday)
            }, onFailure: {error in
                print("called ERROR GraphViewModel: \(error)")
            }
            ).disposed(by: disposeBag)
    }
    
    /// 데이터 가공
    private func processingData(_ priceInfos: PriceData, regday: String) {
        ///가격 데이터 가공
        let prices: [Double] = [
            priceInfos.d0,
            priceInfos.d10,
            priceInfos.d20,
            priceInfos.d30,
            priceInfos.d40
        ]
        .compactMap {
            Double($0.asString().replacingOccurrences(of: ",", with: ""))
        }
        
        // 날짜 계산
        var calculatedDates: [String] = [regday]
        for _ in 1..<5 {
            if let previousDate = calculatedDates.last, let calculatedDate = calculateDateTenDaysBefore(dateString: previousDate) {
                calculatedDates.append(calculatedDate)
            }
        }
        
        /// 등락률 계산
        var previousPrice: Double? = nil
        var tableDatas: [[String]] = []
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        for index in (0..<prices.count).reversed() {
            let price = prices[index]
            var changeRateString = "-"
            
            if let previousPrice = previousPrice {
                let changeRate = ((price - previousPrice) / previousPrice) * 100
                changeRateString = String(format: "%.2f", changeRate) + "%"
            }
            
            let date = index < calculatedDates.count ? calculatedDates[index] : ""
            tableDatas.insert([date, numberFormatter.string(from: NSNumber(value: price)) ?? "\(price)", changeRateString], at: 0)
            previousPrice = price
        }
        tableDatas.insert(["날짜", "가격", "등락률"], at: 0)
        priceData.accept(prices)
        dateData.accept(calculatedDates)
        tableData.accept(tableDatas)
    }
    
    /// API로 가져온 데이터의 날짜를 정확하게 계산하는 메서드
    private func calculateDateTenDaysBefore(dateString: String?) -> String? {
        guard let dateString = dateString else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: dateString) else { return nil }
        let calendar = Calendar.current
        guard let tenDaysBefore = calendar.date(byAdding: .day, value: -10, to: date) else { return nil }
        return dateFormatter.string(from: tenDaysBefore)
    }
    
    ///즐겨찾기 추가
    func savedFavoriteCoreData(productno: String) {
        CoreDataManager.shared.saveFavoriteItem(productno: productno)
        alertMessage.onNext("즐겨찾기에 추가되었습니다.")
    }

}
