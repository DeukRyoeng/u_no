//
//  MainModel.swift
//  u_no
//
//  Created by 이득령 on 8/29/24.
//

import Foundation

// MARK: - Foodprices
struct Foodprices: Codable {
    /// 요청 메세지
    let condition: [[String]]
    
    /// 결과 코드
    let errorCode: String
    
    /// 응답 메세지
    let price: [Price]

    enum CodingKeys: String, CodingKey {
        case condition
        case errorCode = "error_code"
        case price
    }
}

// MARK: - Price
struct Price: Codable {
    /// 구분(01:소매, 02:도매)
    let productClsCode: String?
    
    /// 구분 이름
    let productClsName: String?
    
    /// 부류 코드
    let categoryCode: String?
    
    /// 부류 명
    let categoryName: String?
    
    /// 품목 코드
    let productno: String?
    
    /// 최근 조사일
    let lastestDay: String?
    
    /// 품목 명
    let productName: String?
    
    /// 품목 명 (아이템)
    let itemName: String?
    
    /// 단위
    let unit: String?
    
    /// 최근 조사 일자
    let day1: String?
    
    /// 최근 조사 일자 가격
    let dpr1: StringOrArray
    
    /// 1일 전 일자
    let day2: String?
    
    /// 1일 전 가격
    let dpr2: StringOrArray
    
    /// 1개월 전 일자
    let day3: String?
    
    /// 1개월 전 가격
    let dpr3: StringOrArray

    /// 1년 전 일자
    let day4: String?
    
    /// 1년 전 가격
    let dpr4: StringOrArray
    
    /// 등락 여부 (0: 가격 하락, 1: 가격 상승, 2: 등락 없음)
    let direction: StringOrArray
    
    /// 등락율
    let value: StringOrArray
    
    /// 등락율(mainVM 에서 사용할)
    var rate: Double?
    
    enum CodingKeys: String, CodingKey {
        case productClsCode = "product_cls_code"
        case productClsName = "product_cls_name"
        case categoryCode = "category_code"
        case categoryName = "category_name"
        case productno
        case lastestDay = "lastest_day"
        case productName
        case itemName = "item_name"
        case unit, day1, dpr1, day2, dpr2, day3, dpr3, day4, dpr4, direction, value
    }
}
// MARK: - SearchData
/// 검색하여 불러오기
struct SearchData: Codable {
    let condition: [Condition]
    let data: DataClass
}

struct Condition: Codable {
    let pStartday, pEndday, pItemcategorycode, pItemcode: String
    let pKindcode, pProductrankcode, pConvertKgYn, pKey: String
    let pID, pReturntype: String
    let pCountycode: [String] // 수정: pCountycode를 String에서 [String] 배열로 변경

    enum CodingKeys: String, CodingKey {
        case pStartday = "p_startday"
        case pEndday = "p_endday"
        case pItemcategorycode = "p_itemcategorycode"
        case pItemcode = "p_itemcode"
        case pKindcode = "p_kindcode"
        case pProductrankcode = "p_productrankcode"
        case pConvertKgYn = "p_convert_kg_yn"
        case pKey = "p_key"
        case pID = "p_id"
        case pReturntype = "p_returntype"
        case pCountycode = "p_countycode" // 배열로 정의된 p_countycode 추가
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let errorCode: String
    let item: [Item]
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case item
    }
}

// MARK: - Item
struct Item: Codable {
    let itemname, kindname, marketname: StringOrArray
    
    let countyname: String
    let yyyy, regday, price: String
}
// MARK: - StringOrArray
enum StringOrArray: Codable {
    case string(String)
    case array([String])
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let str = try? container.decode(String.self) {
            self = .string(str)
        } else if let arr = try? container.decode([String].self) {
            self = .array(arr)
        } else {
            throw DecodingError.typeMismatch(
                StringOrArray.self,
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Expected a String or Array"
                )
            )
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let str):
            try container.encode(str)
        case .array(let arr):
            try container.encode(arr)
        }
    }
}

// StringOrArrey 타입 확장
extension StringOrArray {
    func asString() -> String {
        switch self {
        case .string(let str):
            return str
        case .array(let arr):
            return arr.first ?? ""
        }
    }
}


