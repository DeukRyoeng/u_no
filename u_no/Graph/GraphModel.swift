//
//  GraphModel.swift
//  u_no
//
//  Created by 백시훈 on 9/6/24.
//

import Foundation

struct GraphPrice: Codable {
    /// 요청 메세지
    let condition: [[String: String]]
    
    /// 응답 메세지
    let data: grapData
    
    enum CodingKeys: String, CodingKey {
        case condition
        case data
    }
}
struct grapData: Codable{
    
    /// 결과 코드
    let errorCode: String
    
    let item: [PriceInfo]
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case item
    }
}

struct PriceInfo: Codable {
    
    /// 품목 명 (아이템)
    let itemName: StringOrArray
    /// 품종 명
    let kindName: StringOrArray
    /// 시 군 구
    let countyName: String?
    /// 마켓 이름
    let marketName: StringOrArray
    /// 연도
    let yyyy: String?
    /// 날짜
    let regday: String?
    /// 가격
    let price: String?
    
    enum CodingKeys: String, CodingKey {
        case itemName = "itemname"
        case kindName = "kindname"
        case countyName = "countyname"
        case marketName = "marketname"
        case yyyy, regday, price
    }
}


