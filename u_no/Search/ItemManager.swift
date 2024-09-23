//
//  SearchModel.swift
//  u_no
//
//  Created by 이득령 on 9/8/24.
//

import Foundation

struct ItemCode {
    /// 부류코드
    let itemcategory: String
    /// 품목코드
    let itemcode: String
    /// 품종코드
    let kindcode: String
}

struct ItemCategory {
    let name: String
    let codes: [ItemCode]
}
class ItemManager {
    
    static let shared = ItemManager()
    private init() {}
    
    
    ///검색시 필요한 코드들
    private let itemCategorys: [String: ItemCategory] = [
        "쌀": ItemCategory(name: "쌀", codes: [
            ItemCode(itemcategory: "100", itemcode: "111", kindcode: "01"),
            ItemCode(itemcategory: "100", itemcode: "111", kindcode: "02"),
            ItemCode(itemcategory: "100", itemcode: "111", kindcode: "03"),
            ItemCode(itemcategory: "100", itemcode: "111", kindcode: "05"),
            ItemCode(itemcategory: "100", itemcode: "111", kindcode: "10"),
            ItemCode(itemcategory: "100", itemcode: "111", kindcode: "11"),
        ]),
        "찹쌀": ItemCategory(name: "찹쌀", codes: [
            ItemCode(itemcategory: "100", itemcode: "112", kindcode: "01"),
        ]),
        "혼합곡": ItemCategory(name: "혼합곡", codes: [
            ItemCode(itemcategory: "100", itemcode: "113", kindcode: "00"),
        ]),
        "기장": ItemCategory(name: "기장", codes: [
            ItemCode(itemcategory: "100", itemcode: "114", kindcode: "01"),
        ]),
        "콩": ItemCategory(name: "콩", codes: [
            ItemCode(itemcategory: "100", itemcode: "141", kindcode: "01"),
            ItemCode(itemcategory: "100", itemcode: "141", kindcode: "02"),
            ItemCode(itemcategory: "100", itemcode: "141", kindcode: "03"),
        ]),
        "팥": ItemCategory(name: "팥", codes: [
            ItemCode(itemcategory: "100", itemcode: "142", kindcode: "00"),
            ItemCode(itemcategory: "100", itemcode: "142", kindcode: "01"),
        ]),
        "녹두": ItemCategory(name: "녹두", codes: [
            ItemCode(itemcategory: "100", itemcode: "143", kindcode: "00"),
            ItemCode(itemcategory: "100", itemcode: "143", kindcode: "01"),
        ]),
        "메밀": ItemCategory(name: "메밀", codes: [
            ItemCode(itemcategory: "100", itemcode: "144", kindcode: "01"),
        ]),
        "고구마": ItemCategory(name: "고구마", codes: [
            ItemCode(itemcategory: "100", itemcode: "151", kindcode: "00"),
        ]),
        "감자": ItemCategory(name: "감자", codes: [
            ItemCode(itemcategory: "100", itemcode: "152", kindcode: "00"),
            ItemCode(itemcategory: "100", itemcode: "152", kindcode: "01"),
            ItemCode(itemcategory: "100", itemcode: "152", kindcode: "02"),
            ItemCode(itemcategory: "100", itemcode: "152", kindcode: "03"),
            ItemCode(itemcategory: "100", itemcode: "152", kindcode: "04"),
            ItemCode(itemcategory: "100", itemcode: "152", kindcode: "05"),
            ItemCode(itemcategory: "100", itemcode: "152", kindcode: "06"),
        ]),
        "귀리": ItemCategory(name: "귀리", codes: [
            ItemCode(itemcategory: "100", itemcode: "161", kindcode: "01"),
        ]),
        "보리": ItemCategory(name: "보리", codes: [
            ItemCode(itemcategory: "100", itemcode: "162", kindcode: "01"),
        ]),
        "수수": ItemCategory(name: "수수", codes: [
            ItemCode(itemcategory: "100", itemcode: "163", kindcode: "01"),
        ]),
        "율무": ItemCategory(name: "율무", codes: [
            ItemCode(itemcategory: "100", itemcode: "164", kindcode: "01"),
        ]),
        "배추": ItemCategory(name: "배추", codes: [
            ItemCode(itemcategory: "200", itemcode: "211", kindcode: "01"),
            ItemCode(itemcategory: "200", itemcode: "211", kindcode: "02"),
            ItemCode(itemcategory: "200", itemcode: "211", kindcode: "03"),
            ItemCode(itemcategory: "200", itemcode: "211", kindcode: "06"),
        ]),
        "양배추": ItemCategory(name: "양배추", codes: [
            ItemCode(itemcategory: "200", itemcode: "212", kindcode: "00"),
        ]),
        "시금치": ItemCategory(name: "시금치", codes: [
            ItemCode(itemcategory: "200", itemcode: "213", kindcode: "00"),
        ]),
        "상추": ItemCategory(name: "상추", codes: [
            ItemCode(itemcategory: "200", itemcode: "214", kindcode: "01"),
            ItemCode(itemcategory: "200", itemcode: "214", kindcode: "2"),
        ]),
        "얼갈이배추": ItemCategory(name: "얼갈이배추", codes: [
            ItemCode(itemcategory: "200", itemcode: "215", kindcode: "00"),
        ]),
        "갓": ItemCategory(name: "갓", codes: [
            ItemCode(itemcategory: "200", itemcode: "216", kindcode: "00"),
        ]),
        "연근": ItemCategory(name: "연근", codes: [
            ItemCode(itemcategory: "200", itemcode: "217", kindcode: "01"),
        ]),
        "우엉": ItemCategory(name: "우엉", codes: [
            ItemCode(itemcategory: "200", itemcode: "218", kindcode: "01"),
        ]),
        "수박": ItemCategory(name: "수박", codes: [
            ItemCode(itemcategory: "200", itemcode: "221", kindcode: "00"),
        ]),
        "참외": ItemCategory(name: "참외", codes: [
            ItemCode(itemcategory: "200", itemcode: "222", kindcode: "00"),
        ]),
        "오이": ItemCategory(name: "오이", codes: [
            ItemCode(itemcategory: "200", itemcode: "223", kindcode: "01"),
            ItemCode(itemcategory: "200", itemcode: "223", kindcode: "02"),
            ItemCode(itemcategory: "200", itemcode: "223", kindcode: "03"),
        ]),
        "호박": ItemCategory(name: "호박", codes: [
            ItemCode(itemcategory: "200", itemcode: "224", kindcode: "01"),
            ItemCode(itemcategory: "200", itemcode: "224", kindcode: "02"),
            ItemCode(itemcategory: "200", itemcode: "224", kindcode: "03"),
        ]),
        "토마토": ItemCategory(name: "토마토", codes: [
            ItemCode(itemcategory: "200", itemcode: "225", kindcode: "00"),
        ]),
        "딸기": ItemCategory(name: "딸기", codes: [
            ItemCode(itemcategory: "200", itemcode: "226", kindcode: "00"),
        ]),
        "무": ItemCategory(name: "무", codes: [
            ItemCode(itemcategory: "200", itemcode: "231", kindcode: "01"),
            ItemCode(itemcategory: "200", itemcode: "231", kindcode: "02"),
            ItemCode(itemcategory: "200", itemcode: "231", kindcode: "03"),
            ItemCode(itemcategory: "200", itemcode: "231", kindcode: "06"),
        ]),
        "당근": ItemCategory(name: "당근", codes: [
            ItemCode(itemcategory: "200", itemcode: "232", kindcode: "00"),
            ItemCode(itemcategory: "200", itemcode: "232", kindcode: "01"),
            ItemCode(itemcategory: "200", itemcode: "232", kindcode: "02"),
            ItemCode(itemcategory: "200", itemcode: "232", kindcode: "10"),
        ]),
        "열무": ItemCategory(name: "열무", codes: [
            ItemCode(itemcategory: "200", itemcode: "233", kindcode: "00"),
        ]),
        "건고추": ItemCategory(name: "건고추", codes: [
            ItemCode(itemcategory: "200", itemcode: "241", kindcode: "00"),
            ItemCode(itemcategory: "200", itemcode: "241", kindcode: "01"),
            ItemCode(itemcategory: "200", itemcode: "241", kindcode: "02"),
            ItemCode(itemcategory: "200", itemcode: "241", kindcode: "03"),
            ItemCode(itemcategory: "200", itemcode: "241", kindcode: "10"),
        ]),
        "풋고추": ItemCategory(name: "풋고추", codes: [
            ItemCode(itemcategory: "200", itemcode: "242", kindcode: "00"),
            ItemCode(itemcategory: "200", itemcode: "242", kindcode: "02"),
            ItemCode(itemcategory: "200", itemcode: "242", kindcode: "03"),
            ItemCode(itemcategory: "200", itemcode: "242", kindcode: "04"),
        ]),
        "붉은고추": ItemCategory(name: "붉은고추", codes: [
            ItemCode(itemcategory: "200", itemcode: "243", kindcode: "00"),
        ]),
        "피마늘": ItemCategory(name: "피마늘", codes: [
            ItemCode(itemcategory: "200", itemcode: "244", kindcode: "01"),
            ItemCode(itemcategory: "200", itemcode: "244", kindcode: "02"),
            ItemCode(itemcategory: "200", itemcode: "244", kindcode: "03"),
            ItemCode(itemcategory: "200", itemcode: "244", kindcode: "04"),
            ItemCode(itemcategory: "200", itemcode: "244", kindcode: "06"),
            ItemCode(itemcategory: "200", itemcode: "244", kindcode: "07"),
            ItemCode(itemcategory: "200", itemcode: "244", kindcode: "08"),
            ItemCode(itemcategory: "200", itemcode: "244", kindcode: "21"),
            ItemCode(itemcategory: "200", itemcode: "244", kindcode: "22"),
            ItemCode(itemcategory: "200", itemcode: "244", kindcode: "23"),
            ItemCode(itemcategory: "200", itemcode: "244", kindcode: "24"),
        ]),
        "양파": ItemCategory(name: "양파", codes: [
            ItemCode(itemcategory: "200", itemcode: "245", kindcode: "00"),
            ItemCode(itemcategory: "200", itemcode: "245", kindcode: "02"),
            ItemCode(itemcategory: "200", itemcode: "245", kindcode: "10"),
        ]),
        "파": ItemCategory(name: "파", codes: [
            ItemCode(itemcategory: "200", itemcode: "246", kindcode: "00"),
            ItemCode(itemcategory: "200", itemcode: "246", kindcode: "02"),
        ]),
        "생강": ItemCategory(name: "생강", codes: [
            ItemCode(itemcategory: "200", itemcode: "247", kindcode: "00"),
            ItemCode(itemcategory: "200", itemcode: "247", kindcode: "01"),
        ]),
        "고춧가루": ItemCategory(name: "고춧가루", codes: [
            ItemCode(itemcategory: "200", itemcode: "248", kindcode: "00"),
            ItemCode(itemcategory: "200", itemcode: "248", kindcode: "01"),
        ]),
        "가지": ItemCategory(name: "가지", codes: [
            ItemCode(itemcategory: "200", itemcode: "251", kindcode: "00"),
        ]),
        "미나리": ItemCategory(name: "미나리", codes: [
            ItemCode(itemcategory: "200", itemcode: "252", kindcode: "00"),
        ]),
        "깻잎": ItemCategory(name: "깻잎", codes: [
            ItemCode(itemcategory: "200", itemcode: "253", kindcode: "00"),
        ]),
        "부추": ItemCategory(name: "부추", codes: [
            ItemCode(itemcategory: "200", itemcode: "254", kindcode: "00"),
        ]),
        "피망": ItemCategory(name: "피망", codes: [
            ItemCode(itemcategory: "200", itemcode: "255", kindcode: "00"),
        ]),
        "파프리카": ItemCategory(name: "파프리카", codes: [
            ItemCode(itemcategory: "200", itemcode: "256", kindcode: "00"),
        ]),
        "멜론": ItemCategory(name: "멜론", codes: [
            ItemCode(itemcategory: "200", itemcode: "257", kindcode: "00"),
        ]),
        "깐마늘(국산)": ItemCategory(name: "깐마늘(국산)", codes: [
            ItemCode(itemcategory: "200", itemcode: "258", kindcode: "01"),
            ItemCode(itemcategory: "200", itemcode: "258", kindcode: "03"),
            ItemCode(itemcategory: "200", itemcode: "258", kindcode: "04"),
            ItemCode(itemcategory: "200", itemcode: "258", kindcode: "05"),
            ItemCode(itemcategory: "200", itemcode: "258", kindcode: "06"),
        ]),
        "깐마늘(수입)": ItemCategory(name: "깐마늘(수입)", codes: [
            ItemCode(itemcategory: "200", itemcode: "259", kindcode: "01"),
            ItemCode(itemcategory: "200", itemcode: "259", kindcode: "03"),
        ]),
        "브로콜리": ItemCategory(name: "브로콜리", codes: [
            ItemCode(itemcategory: "200", itemcode: "261", kindcode: "01"),
            ItemCode(itemcategory: "200", itemcode: "280", kindcode: "00"),
        ]),
        "양상추": ItemCategory(name: "양상추", codes: [
            ItemCode(itemcategory: "200", itemcode: "262", kindcode: "01"),
        ]),
        "청경채": ItemCategory(name: "청경채", codes: [
            ItemCode(itemcategory: "200", itemcode: "263", kindcode: "01"),
        ]),
        "케일": ItemCategory(name: "케일", codes: [
            ItemCode(itemcategory: "200", itemcode: "264", kindcode: "01"),
        ]),
        "콩나물": ItemCategory(name: "콩나물", codes: [
            ItemCode(itemcategory: "200", itemcode: "265", kindcode: "01"),
        ]),
        "알배기배추": ItemCategory(name: "알배기배추", codes: [
            ItemCode(itemcategory: "200", itemcode: "279", kindcode: "00"),
        ]),
        "참깨": ItemCategory(name: "참깨", codes: [
            ItemCode(itemcategory: "300", itemcode: "312", kindcode: "01"),
            ItemCode(itemcategory: "300", itemcode: "312", kindcode: "02"),
            ItemCode(itemcategory: "300", itemcode: "312", kindcode: "03"),
        ]),
        "들깨": ItemCategory(name: "들깨", codes: [
            ItemCode(itemcategory: "300", itemcode: "313", kindcode: "01"),
            ItemCode(itemcategory: "300", itemcode: "313", kindcode: "02"),
        ]),
        "땅콩": ItemCategory(name: "땅콩", codes: [
            ItemCode(itemcategory: "300", itemcode: "314", kindcode: "01"),
            ItemCode(itemcategory: "300", itemcode: "314", kindcode: "02"),
        ]),
        "느타리버섯": ItemCategory(name: "느타리버섯", codes: [
            ItemCode(itemcategory: "300", itemcode: "315", kindcode: "00"),
            ItemCode(itemcategory: "300", itemcode: "315", kindcode: "01"),
        ]),
        "팽이버섯": ItemCategory(name: "팽이버섯", codes: [
            ItemCode(itemcategory: "300", itemcode: "316", kindcode: "00"),
        ]),
        "새송이버섯": ItemCategory(name: "새송이버섯", codes: [
            ItemCode(itemcategory: "300", itemcode: "317", kindcode: "00"),
        ]),
        "호두": ItemCategory(name: "호두", codes: [
            ItemCode(itemcategory: "300", itemcode: "318", kindcode: "00"),
        ]),
        "아몬드": ItemCategory(name: "아몬드", codes: [
            ItemCode(itemcategory: "300", itemcode: "319", kindcode: "00"),
        ]),
        "양송이버섯": ItemCategory(name: "양송이버섯", codes: [
            ItemCode(itemcategory: "300", itemcode: "321", kindcode: "01"),
        ]),
        "표고버섯": ItemCategory(name: "표고버섯", codes: [
            ItemCode(itemcategory: "300", itemcode: "322", kindcode: "01"),
        ]),
        "사과": ItemCategory(name: "사과", codes: [
            ItemCode(itemcategory: "400", itemcode: "411", kindcode: "01"),
            ItemCode(itemcategory: "400", itemcode: "411", kindcode: "05"),
            ItemCode(itemcategory: "400", itemcode: "411", kindcode: "06"),
            ItemCode(itemcategory: "400", itemcode: "411", kindcode: "07"),
        ]),
        "배": ItemCategory(name: "배", codes: [
            ItemCode(itemcategory: "400", itemcode: "412", kindcode: "01"),
            ItemCode(itemcategory: "400", itemcode: "412", kindcode: "02"),
            ItemCode(itemcategory: "400", itemcode: "412", kindcode: "03"),
            ItemCode(itemcategory: "400", itemcode: "412", kindcode: "04"),
        ]),
        "복숭아": ItemCategory(name: "복숭아", codes: [
            ItemCode(itemcategory: "400", itemcode: "413", kindcode: "01"),
            ItemCode(itemcategory: "400", itemcode: "413", kindcode: "04"),
            ItemCode(itemcategory: "400", itemcode: "413", kindcode: "05"),
        ]),
        "포도": ItemCategory(name: "포도", codes: [
            ItemCode(itemcategory: "400", itemcode: "414", kindcode: "01"),
            ItemCode(itemcategory: "400", itemcode: "414", kindcode: "02"),
            ItemCode(itemcategory: "400", itemcode: "414", kindcode: "03"),
            ItemCode(itemcategory: "400", itemcode: "414", kindcode: "06"),
            ItemCode(itemcategory: "400", itemcode: "414", kindcode: "07"),
            ItemCode(itemcategory: "400", itemcode: "414", kindcode: "08"),
            ItemCode(itemcategory: "400", itemcode: "414", kindcode: "09"),
            ItemCode(itemcategory: "400", itemcode: "414", kindcode: "10"),
            ItemCode(itemcategory: "400", itemcode: "414", kindcode: "11"),
            ItemCode(itemcategory: "400", itemcode: "414", kindcode: "12"),
        ]),
        "감귤": ItemCategory(name: "감귤", codes: [
            ItemCode(itemcategory: "400", itemcode: "415", kindcode: "00"),
            ItemCode(itemcategory: "400", itemcode: "415", kindcode: "01"),
            ItemCode(itemcategory: "400", itemcode: "415", kindcode: "02"),
        ]),
        "단감": ItemCategory(name: "단감", codes: [
            ItemCode(itemcategory: "400", itemcode: "416", kindcode: "00"),
        ]),
        "바나나": ItemCategory(name: "바나나", codes: [
            ItemCode(itemcategory: "400", itemcode: "418", kindcode: "02"),
        ]),
        "참다래": ItemCategory(name: "참다래", codes: [
            ItemCode(itemcategory: "400", itemcode: "419", kindcode: "01"),
            ItemCode(itemcategory: "400", itemcode: "419", kindcode: "02"),
        ]),
        "파인애플": ItemCategory(name: "파인애플", codes: [
            ItemCode(itemcategory: "400", itemcode: "420", kindcode: "02"),
        ]),
        "오렌지": ItemCategory(name: "오렌지", codes: [
            ItemCode(itemcategory: "400", itemcode: "421", kindcode: "02"),
            ItemCode(itemcategory: "400", itemcode: "421", kindcode: "03"),
            ItemCode(itemcategory: "400", itemcode: "421", kindcode: "04"),
            ItemCode(itemcategory: "400", itemcode: "421", kindcode: "05"),
            ItemCode(itemcategory: "400", itemcode: "421", kindcode: "06"),
        ]),
        "방울토마토": ItemCategory(name: "방울토마토", codes: [
            ItemCode(itemcategory: "200", itemcode: "422", kindcode: "01"),
            ItemCode(itemcategory: "200", itemcode: "422", kindcode: "02"),
        ]),
        "자몽": ItemCategory(name: "자몽", codes: [
            ItemCode(itemcategory: "400", itemcode: "423", kindcode: "00"),
        ]),
        "레몬": ItemCategory(name: "레몬", codes: [
            ItemCode(itemcategory: "400", itemcode: "424", kindcode: "00"),
        ]),
        "체리": ItemCategory(name: "체리", codes: [
            ItemCode(itemcategory: "400", itemcode: "425", kindcode: "00"),
        ]),
        "건포도": ItemCategory(name: "건포도", codes: [
            ItemCode(itemcategory: "400", itemcode: "426", kindcode: "00"),
        ]),
        "건블루베리": ItemCategory(name: "건블루베리", codes: [
            ItemCode(itemcategory: "400", itemcode: "427", kindcode: "00"),
        ]),
        "망고": ItemCategory(name: "망고", codes: [
            ItemCode(itemcategory: "400", itemcode: "428", kindcode: "00"),
        ]),
        "블루베리": ItemCategory(name: "블루베리", codes: [
            ItemCode(itemcategory: "400", itemcode: "429", kindcode: "01"),
        ]),
        "아보카도": ItemCategory(name: "아보카도", codes: [
            ItemCode(itemcategory: "400", itemcode: "430", kindcode: "00"),
        ]),
        "고등어": ItemCategory(name: "고등어", codes: [
            ItemCode(itemcategory: "600", itemcode: "611", kindcode: "01"),
            ItemCode(itemcategory: "600", itemcode: "611", kindcode: "02"),
            ItemCode(itemcategory: "600", itemcode: "611", kindcode: "03"),
            ItemCode(itemcategory: "600", itemcode: "611", kindcode: "04"),
            ItemCode(itemcategory: "600", itemcode: "611", kindcode: "05"),
            ItemCode(itemcategory: "600", itemcode: "611", kindcode: "06"),
            ItemCode(itemcategory: "600", itemcode: "611", kindcode: "07"),
            ItemCode(itemcategory: "600", itemcode: "611", kindcode: "08"),
        ]),
        "꽁치": ItemCategory(name: "꽁치", codes: [
            ItemCode(itemcategory: "600", itemcode: "612", kindcode: "01"),
        ]),
        "갈치": ItemCategory(name: "갈치", codes: [
            ItemCode(itemcategory: "600", itemcode: "613", kindcode: "01"),
            ItemCode(itemcategory: "600", itemcode: "613", kindcode: "02"),
            ItemCode(itemcategory: "600", itemcode: "613", kindcode: "03"),
            ItemCode(itemcategory: "600", itemcode: "613", kindcode: "04"),
            ItemCode(itemcategory: "600", itemcode: "613", kindcode: "05"),
        ]),
        "조기": ItemCategory(name: "조기", codes: [
            ItemCode(itemcategory: "600", itemcode: "614", kindcode: "01"),
            ItemCode(itemcategory: "600", itemcode: "614", kindcode: "04"),
            ItemCode(itemcategory: "600", itemcode: "614", kindcode: "05"),
            ItemCode(itemcategory: "600", itemcode: "614", kindcode: "06"),
            ItemCode(itemcategory: "600", itemcode: "614", kindcode: "07"),
        ]),
        "명태": ItemCategory(name: "명태", codes: [
            ItemCode(itemcategory: "600", itemcode: "615", kindcode: "01"),
            ItemCode(itemcategory: "600", itemcode: "615", kindcode: "02"),
            ItemCode(itemcategory: "600", itemcode: "615", kindcode: "03"),
            ItemCode(itemcategory: "600", itemcode: "615", kindcode: "04"),
            ItemCode(itemcategory: "600", itemcode: "615", kindcode: "05"),
        ]),
        "삼치": ItemCategory(name: "삼치", codes: [
            ItemCode(itemcategory: "600", itemcode: "616", kindcode: "02"),
        ]),
        "물오징어": ItemCategory(name: "물오징어", codes: [
            ItemCode(itemcategory: "600", itemcode: "619", kindcode: "01"),
            ItemCode(itemcategory: "600", itemcode: "619", kindcode: "02"),
            ItemCode(itemcategory: "600", itemcode: "619", kindcode: "03"),
            ItemCode(itemcategory: "600", itemcode: "619", kindcode: "04"),
            ItemCode(itemcategory: "600", itemcode: "619", kindcode: "05"),
        ]),
        "건멸치": ItemCategory(name: "건멸치", codes: [
            ItemCode(itemcategory: "600", itemcode: "638", kindcode: "00"),
        ]),
        "북어": ItemCategory(name: "북어", codes: [
            ItemCode(itemcategory: "600", itemcode: "639", kindcode: "01"),
            ItemCode(itemcategory: "600", itemcode: "639", kindcode: "02"),
        ]),
        "건오징어": ItemCategory(name: "건오징어", codes: [
            ItemCode(itemcategory: "600", itemcode: "640", kindcode: "00"),
        ]),
        "김": ItemCategory(name: "김", codes: [
            ItemCode(itemcategory: "600", itemcode: "641", kindcode: "00"),
            ItemCode(itemcategory: "600", itemcode: "641", kindcode: "01"),
        ]),
        "건미역": ItemCategory(name: "건미역", codes: [
            ItemCode(itemcategory: "600", itemcode: "642", kindcode: "00"),
        ]),
        "굴": ItemCategory(name: "굴", codes: [
            ItemCode(itemcategory: "600", itemcode: "644", kindcode: "00"),
        ]),
        "수입조기": ItemCategory(name: "수입조기", codes: [
            ItemCode(itemcategory: "600", itemcode: "649", kindcode: "01"),
            ItemCode(itemcategory: "600", itemcode: "649", kindcode: "04"),
        ]),
        "새우젓": ItemCategory(name: "새우젓", codes: [
            ItemCode(itemcategory: "600", itemcode: "650", kindcode: "00"),
        ]),
        "멸치액젓": ItemCategory(name: "멸치액젓", codes: [
            ItemCode(itemcategory: "600", itemcode: "651", kindcode: "00"),
        ]),
        "굵은소금": ItemCategory(name: "굵은소금", codes: [
            ItemCode(itemcategory: "600", itemcode: "652", kindcode: "00"),
        ]),
        "전복": ItemCategory(name: "전복", codes: [
            ItemCode(itemcategory: "600", itemcode: "653", kindcode: "00"),
        ]),
        "새우": ItemCategory(name: "새우", codes: [
            ItemCode(itemcategory: "600", itemcode: "654", kindcode: "01"),
        ])
    ]
    ///카테고리 가져오기
    func getItemCategory(for name: String) -> ItemCategory? {
        return itemCategorys[name]
    }
    
    func getAllCodes(for query: String) {
        guard let category = getItemCategory(for: query) else {
            print("코드를 찾을 수 없습니다.")
            return
        }
        print("품목명: \(category.name)")
        for code in category.codes {
            print("부류코드: \(code.itemcategory), 품목코드: \(code.itemcode), 품종코드: \(code.kindcode)")
        }
    }
}
