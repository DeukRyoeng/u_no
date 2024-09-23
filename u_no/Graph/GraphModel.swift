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
    
    
    let errorCode: String
    
    /// 응답 메세지
    let price: [PriceData]
    
    enum CodingKeys: String, CodingKey {
        case condition
        case errorCode = "error_code"
        case price
    }
}
struct PriceData: Codable{
    
    let yyyy: String
    
    let d40: StringOrArray
    
    let d30: StringOrArray
    
    let d20: StringOrArray
    
    let d10: StringOrArray
    
    let d0: StringOrArray
    
    let mx: StringOrArray
    
    let mn: StringOrArray
    
}
