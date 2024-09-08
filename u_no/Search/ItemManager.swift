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
    
    private let itemCategorys: [String: ItemCategory] = [
        "쌀": ItemCategory(name: "쌀", codes: [
            ItemCode(itemcategory: "100", itemcode: "111", kindcode: "1"),
            ItemCode(itemcategory: "100", itemcode: "111", kindcode: "2"),
            ItemCode(itemcategory: "100", itemcode: "111", kindcode: "3"),
            ItemCode(itemcategory: "100", itemcode: "111", kindcode: "5"),
            ItemCode(itemcategory: "100", itemcode: "111", kindcode: "10"),
            ItemCode(itemcategory: "100", itemcode: "111", kindcode: "11"),
        ]),
        "찹쌀": ItemCategory(name: "찹쌀", codes: [
            ItemCode(itemcategory: "100", itemcode: "112", kindcode: "1"),
        ]),
        "혼합곡": ItemCategory(name: "혼합곡", codes: [
            ItemCode(itemcategory: "100", itemcode: "113", kindcode: "0"),
        ]),
        "기장": ItemCategory(name: "기장", codes: [
            ItemCode(itemcategory: "100", itemcode: "114", kindcode: "1"),
        ]),
        "콩": ItemCategory(name: "콩", codes: [
            ItemCode(itemcategory: "100", itemcode: "141", kindcode: "1"),
            ItemCode(itemcategory: "100", itemcode: "141", kindcode: "2"),
            ItemCode(itemcategory: "100", itemcode: "141", kindcode: "3"),
        ]),
        "팥": ItemCategory(name: "팥", codes: [
            ItemCode(itemcategory: "100", itemcode: "142", kindcode: "0"),
            ItemCode(itemcategory: "100", itemcode: "142", kindcode: "1"),
        ]),
        "녹두": ItemCategory(name: "녹두", codes: [
            ItemCode(itemcategory: "100", itemcode: "143", kindcode: "0"),
            ItemCode(itemcategory: "100", itemcode: "143", kindcode: "1"),
        ]),
        "메밀": ItemCategory(name: "메밀", codes: [
            ItemCode(itemcategory: "100", itemcode: "144", kindcode: "1"),
        ]),
        "고구마": ItemCategory(name: "고구마", codes: [
            ItemCode(itemcategory: "100", itemcode: "151", kindcode: "0"),
        ]),
        "감자": ItemCategory(name: "감자", codes: [
            ItemCode(itemcategory: "100", itemcode: "152", kindcode: "0"),
            ItemCode(itemcategory: "100", itemcode: "152", kindcode: "1"),
            ItemCode(itemcategory: "100", itemcode: "152", kindcode: "2"),
            ItemCode(itemcategory: "100", itemcode: "152", kindcode: "3"),
            ItemCode(itemcategory: "100", itemcode: "152", kindcode: "4"),
            ItemCode(itemcategory: "100", itemcode: "152", kindcode: "5"),
            ItemCode(itemcategory: "100", itemcode: "152", kindcode: "6"),
        ]),
        "귀리": ItemCategory(name: "귀리", codes: [
            ItemCode(itemcategory: "100", itemcode: "161", kindcode: "1"),
        ]),
        "보리": ItemCategory(name: "보리", codes: [
            ItemCode(itemcategory: "100", itemcode: "162", kindcode: "1"),
        ]),
        "수수": ItemCategory(name: "수수", codes: [
            ItemCode(itemcategory: "100", itemcode: "163", kindcode: "1"),
        ]),
        "율무": ItemCategory(name: "율무", codes: [
            ItemCode(itemcategory: "100", itemcode: "164", kindcode: "1"),
        ]),
        "배추": ItemCategory(name: "배추", codes: [
            ItemCode(itemcategory: "200", itemcode: "211", kindcode: "1"),
            ItemCode(itemcategory: "200", itemcode: "211", kindcode: "2"),
            ItemCode(itemcategory: "200", itemcode: "211", kindcode: "3"),
            ItemCode(itemcategory: "200", itemcode: "211", kindcode: "6"),
        ]),
        "양배추": ItemCategory(name: "양배추", codes: [
            ItemCode(itemcategory: "200", itemcode: "212", kindcode: "0"),
        ]),
        "시금치": ItemCategory(name: "시금치", codes: [
            ItemCode(itemcategory: "200", itemcode: "213", kindcode: "0"),
        ]),
        "상추": ItemCategory(name: "상추", codes: [
            ItemCode(itemcategory: "200", itemcode: "214", kindcode: "1"),
            ItemCode(itemcategory: "200", itemcode: "214", kindcode: "2"),
        ]),
        "얼갈이배추": ItemCategory(name: "얼갈이배추", codes: [
            ItemCode(itemcategory: "200", itemcode: "215", kindcode: "0"),
        ]),
        "갓": ItemCategory(name: "갓", codes: [
            ItemCode(itemcategory: "200", itemcode: "216", kindcode: "0"),
        ]),
        "연근": ItemCategory(name: "연근", codes: [
            ItemCode(itemcategory: "200", itemcode: "217", kindcode: "1"),
        ]),
        "우엉": ItemCategory(name: "우엉", codes: [
            ItemCode(itemcategory: "200", itemcode: "218", kindcode: "1"),
        ]),
        "수박": ItemCategory(name: "수박", codes: [
            ItemCode(itemcategory: "200", itemcode: "221", kindcode: "0"),
        ]),
        "참외": ItemCategory(name: "참외", codes: [
            ItemCode(itemcategory: "200", itemcode: "222", kindcode: "0"),
        ]),
        "오이": ItemCategory(name: "오이", codes: [
            ItemCode(itemcategory: "200", itemcode: "223", kindcode: "1"),
            ItemCode(itemcategory: "200", itemcode: "223", kindcode: "2"),
            ItemCode(itemcategory: "200", itemcode: "223", kindcode: "3"),
        ]),
        "호박": ItemCategory(name: "호박", codes: [
            ItemCode(itemcategory: "200", itemcode: "224", kindcode: "1"),
            ItemCode(itemcategory: "200", itemcode: "224", kindcode: "2"),
            ItemCode(itemcategory: "200", itemcode: "224", kindcode: "3"),
        ]),
        "토마토": ItemCategory(name: "토마토", codes: [
            ItemCode(itemcategory: "200", itemcode: "225", kindcode: "0"),
        ]),
        "딸기": ItemCategory(name: "딸기", codes: [
            ItemCode(itemcategory: "200", itemcode: "226", kindcode: "0"),
        ]),
        "무": ItemCategory(name: "무", codes: [
            ItemCode(itemcategory: "200", itemcode: "231", kindcode: "1"),
            ItemCode(itemcategory: "200", itemcode: "231", kindcode: "2"),
            ItemCode(itemcategory: "200", itemcode: "231", kindcode: "3"),
            ItemCode(itemcategory: "200", itemcode: "231", kindcode: "6"),
        ]),
        "당근": ItemCategory(name: "당근", codes: [
            ItemCode(itemcategory: "200", itemcode: "232", kindcode: "0"),
            ItemCode(itemcategory: "200", itemcode: "232", kindcode: "1"),
            ItemCode(itemcategory: "200", itemcode: "232", kindcode: "2"),
            ItemCode(itemcategory: "200", itemcode: "232", kindcode: "10"),
        ]),
        "열무": ItemCategory(name: "열무", codes: [
            ItemCode(itemcategory: "200", itemcode: "233", kindcode: "0"),
        ]),
        "건고추": ItemCategory(name: "건고추", codes: [
            ItemCode(itemcategory: "200", itemcode: "241", kindcode: "0"),
            ItemCode(itemcategory: "200", itemcode: "241", kindcode: "1"),
            ItemCode(itemcategory: "200", itemcode: "241", kindcode: "2"),
            ItemCode(itemcategory: "200", itemcode: "241", kindcode: "3"),
            ItemCode(itemcategory: "200", itemcode: "241", kindcode: "10"),
        ]),
        "풋고추": ItemCategory(name: "풋고추", codes: [
            ItemCode(itemcategory: "200", itemcode: "242", kindcode: "0"),
            ItemCode(itemcategory: "200", itemcode: "242", kindcode: "2"),
            ItemCode(itemcategory: "200", itemcode: "242", kindcode: "3"),
            ItemCode(itemcategory: "200", itemcode: "242", kindcode: "4"),
        ]),
        "붉은고추": ItemCategory(name: "붉은고추", codes: [
            ItemCode(itemcategory: "200", itemcode: "243", kindcode: "0"),
        ]),
        "피마늘": ItemCategory(name: "피마늘", codes: [
            ItemCode(itemcategory: "200", itemcode: "244", kindcode: "1"),
            ItemCode(itemcategory: "200", itemcode: "244", kindcode: "2"),
            ItemCode(itemcategory: "200", itemcode: "244", kindcode: "3"),
            ItemCode(itemcategory: "200", itemcode: "244", kindcode: "4"),
            ItemCode(itemcategory: "200", itemcode: "244", kindcode: "6"),
            ItemCode(itemcategory: "200", itemcode: "244", kindcode: "7"),
            ItemCode(itemcategory: "200", itemcode: "244", kindcode: "8"),
            ItemCode(itemcategory: "200", itemcode: "244", kindcode: "21"),
            ItemCode(itemcategory: "200", itemcode: "244", kindcode: "22"),
            ItemCode(itemcategory: "200", itemcode: "244", kindcode: "23"),
            ItemCode(itemcategory: "200", itemcode: "244", kindcode: "24"),
        ]),
        "양파": ItemCategory(name: "양파", codes: [
            ItemCode(itemcategory: "200", itemcode: "245", kindcode: "0"),
            ItemCode(itemcategory: "200", itemcode: "245", kindcode: "2"),
            ItemCode(itemcategory: "200", itemcode: "245", kindcode: "10"),
        ]),
        "파": ItemCategory(name: "파", codes: [
            ItemCode(itemcategory: "200", itemcode: "246", kindcode: "0"),
            ItemCode(itemcategory: "200", itemcode: "246", kindcode: "2"),
        ]),
        "생강": ItemCategory(name: "생강", codes: [
            ItemCode(itemcategory: "200", itemcode: "247", kindcode: "0"),
            ItemCode(itemcategory: "200", itemcode: "247", kindcode: "1"),
        ]),
        "고춧가루": ItemCategory(name: "고춧가루", codes: [
            ItemCode(itemcategory: "200", itemcode: "248", kindcode: "0"),
            ItemCode(itemcategory: "200", itemcode: "248", kindcode: "1"),
        ]),
        "가지": ItemCategory(name: "가지", codes: [
            ItemCode(itemcategory: "200", itemcode: "251", kindcode: "0"),
        ]),
        "미나리": ItemCategory(name: "미나리", codes: [
            ItemCode(itemcategory: "200", itemcode: "252", kindcode: "0"),
        ]),
        "깻잎": ItemCategory(name: "깻잎", codes: [
            ItemCode(itemcategory: "200", itemcode: "253", kindcode: "0"),
        ]),
        "부추": ItemCategory(name: "부추", codes: [
            ItemCode(itemcategory: "200", itemcode: "254", kindcode: "0"),
        ]),
        "피망": ItemCategory(name: "피망", codes: [
            ItemCode(itemcategory: "200", itemcode: "255", kindcode: "0"),
        ]),
        "파프리카": ItemCategory(name: "파프리카", codes: [
            ItemCode(itemcategory: "200", itemcode: "256", kindcode: "0"),
        ]),
        "멜론": ItemCategory(name: "멜론", codes: [
            ItemCode(itemcategory: "200", itemcode: "257", kindcode: "0"),
        ]),
        "깐마늘(국산)": ItemCategory(name: "깐마늘(국산)", codes: [
            ItemCode(itemcategory: "200", itemcode: "258", kindcode: "1"),
            ItemCode(itemcategory: "200", itemcode: "258", kindcode: "3"),
            ItemCode(itemcategory: "200", itemcode: "258", kindcode: "4"),
            ItemCode(itemcategory: "200", itemcode: "258", kindcode: "5"),
            ItemCode(itemcategory: "200", itemcode: "258", kindcode: "6"),
        ]),
        "깐마늘(수입)": ItemCategory(name: "깐마늘(수입)", codes: [
            ItemCode(itemcategory: "200", itemcode: "259", kindcode: "1"),
            ItemCode(itemcategory: "200", itemcode: "259", kindcode: "3"),
        ]),
        "브로콜리": ItemCategory(name: "브로콜리", codes: [
            ItemCode(itemcategory: "200", itemcode: "261", kindcode: "1"),
            ItemCode(itemcategory: "200", itemcode: "280", kindcode: "0"),
        ]),
        "양상추": ItemCategory(name: "양상추", codes: [
            ItemCode(itemcategory: "200", itemcode: "262", kindcode: "1"),
        ]),
        "청경채": ItemCategory(name: "청경채", codes: [
            ItemCode(itemcategory: "200", itemcode: "263", kindcode: "1"),
        ]),
        "케일": ItemCategory(name: "케일", codes: [
            ItemCode(itemcategory: "200", itemcode: "264", kindcode: "1"),
        ]),
        "콩나물": ItemCategory(name: "콩나물", codes: [
            ItemCode(itemcategory: "200", itemcode: "265", kindcode: "1"),
        ]),
        "알배기배추": ItemCategory(name: "알배기배추", codes: [
            ItemCode(itemcategory: "200", itemcode: "279", kindcode: "0"),
        ]),
        "참깨": ItemCategory(name: "참깨", codes: [
            ItemCode(itemcategory: "300", itemcode: "312", kindcode: "1"),
            ItemCode(itemcategory: "300", itemcode: "312", kindcode: "2"),
            ItemCode(itemcategory: "300", itemcode: "312", kindcode: "3"),
        ]),
        "들깨": ItemCategory(name: "들깨", codes: [
            ItemCode(itemcategory: "300", itemcode: "313", kindcode: "1"),
            ItemCode(itemcategory: "300", itemcode: "313", kindcode: "2"),
        ]),
        "땅콩": ItemCategory(name: "땅콩", codes: [
            ItemCode(itemcategory: "300", itemcode: "314", kindcode: "1"),
            ItemCode(itemcategory: "300", itemcode: "314", kindcode: "2"),
        ]),
        "느타리버섯": ItemCategory(name: "느타리버섯", codes: [
            ItemCode(itemcategory: "300", itemcode: "315", kindcode: "0"),
            ItemCode(itemcategory: "300", itemcode: "315", kindcode: "1"),
        ]),
        "팽이버섯": ItemCategory(name: "팽이버섯", codes: [
            ItemCode(itemcategory: "300", itemcode: "316", kindcode: "0"),
        ]),
        "새송이버섯": ItemCategory(name: "새송이버섯", codes: [
            ItemCode(itemcategory: "300", itemcode: "317", kindcode: "0"),
        ]),
        "호두": ItemCategory(name: "호두", codes: [
            ItemCode(itemcategory: "300", itemcode: "318", kindcode: "0"),
        ]),
        "아몬드": ItemCategory(name: "아몬드", codes: [
            ItemCode(itemcategory: "300", itemcode: "319", kindcode: "0"),
        ]),
        "양송이버섯": ItemCategory(name: "양송이버섯", codes: [
            ItemCode(itemcategory: "300", itemcode: "321", kindcode: "1"),
        ]),
        "표고버섯": ItemCategory(name: "표고버섯", codes: [
            ItemCode(itemcategory: "300", itemcode: "322", kindcode: "1"),
        ]),
        "사과": ItemCategory(name: "사과", codes: [
            ItemCode(itemcategory: "400", itemcode: "411", kindcode: "1"),
            ItemCode(itemcategory: "400", itemcode: "411", kindcode: "5"),
            ItemCode(itemcategory: "400", itemcode: "411", kindcode: "6"),
            ItemCode(itemcategory: "400", itemcode: "411", kindcode: "7"),
        ]),
        "배": ItemCategory(name: "배", codes: [
            ItemCode(itemcategory: "400", itemcode: "412", kindcode: "1"),
            ItemCode(itemcategory: "400", itemcode: "412", kindcode: "2"),
            ItemCode(itemcategory: "400", itemcode: "412", kindcode: "3"),
            ItemCode(itemcategory: "400", itemcode: "412", kindcode: "4"),
        ]),
        "복숭아": ItemCategory(name: "복숭아", codes: [
            ItemCode(itemcategory: "400", itemcode: "413", kindcode: "1"),
            ItemCode(itemcategory: "400", itemcode: "413", kindcode: "4"),
            ItemCode(itemcategory: "400", itemcode: "413", kindcode: "5"),
        ]),
        "포도": ItemCategory(name: "포도", codes: [
            ItemCode(itemcategory: "400", itemcode: "414", kindcode: "1"),
            ItemCode(itemcategory: "400", itemcode: "414", kindcode: "2"),
            ItemCode(itemcategory: "400", itemcode: "414", kindcode: "3"),
            ItemCode(itemcategory: "400", itemcode: "414", kindcode: "6"),
            ItemCode(itemcategory: "400", itemcode: "414", kindcode: "7"),
            ItemCode(itemcategory: "400", itemcode: "414", kindcode: "8"),
            ItemCode(itemcategory: "400", itemcode: "414", kindcode: "9"),
            ItemCode(itemcategory: "400", itemcode: "414", kindcode: "10"),
            ItemCode(itemcategory: "400", itemcode: "414", kindcode: "11"),
            ItemCode(itemcategory: "400", itemcode: "414", kindcode: "12"),
        ]),
        "감귤": ItemCategory(name: "감귤", codes: [
            ItemCode(itemcategory: "400", itemcode: "415", kindcode: "0"),
            ItemCode(itemcategory: "400", itemcode: "415", kindcode: "1"),
            ItemCode(itemcategory: "400", itemcode: "415", kindcode: "2"),
        ]),
        "단감": ItemCategory(name: "단감", codes: [
            ItemCode(itemcategory: "400", itemcode: "416", kindcode: "0"),
        ]),
        "바나나": ItemCategory(name: "바나나", codes: [
            ItemCode(itemcategory: "400", itemcode: "418", kindcode: "2"),
        ]),
        "참다래": ItemCategory(name: "참다래", codes: [
            ItemCode(itemcategory: "400", itemcode: "419", kindcode: "1"),
            ItemCode(itemcategory: "400", itemcode: "419", kindcode: "2"),
        ]),
        "파인애플": ItemCategory(name: "파인애플", codes: [
            ItemCode(itemcategory: "400", itemcode: "420", kindcode: "2"),
        ]),
        "오렌지": ItemCategory(name: "오렌지", codes: [
            ItemCode(itemcategory: "400", itemcode: "421", kindcode: "2"),
            ItemCode(itemcategory: "400", itemcode: "421", kindcode: "3"),
            ItemCode(itemcategory: "400", itemcode: "421", kindcode: "4"),
            ItemCode(itemcategory: "400", itemcode: "421", kindcode: "5"),
            ItemCode(itemcategory: "400", itemcode: "421", kindcode: "6"),
        ]),
        "방울토마토": ItemCategory(name: "방울토마토", codes: [
            ItemCode(itemcategory: "200", itemcode: "422", kindcode: "1"),
            ItemCode(itemcategory: "200", itemcode: "422", kindcode: "2"),
        ]),
        "자몽": ItemCategory(name: "자몽", codes: [
            ItemCode(itemcategory: "400", itemcode: "423", kindcode: "0"),
        ]),
        "레몬": ItemCategory(name: "레몬", codes: [
            ItemCode(itemcategory: "400", itemcode: "424", kindcode: "0"),
        ]),
        "체리": ItemCategory(name: "체리", codes: [
            ItemCode(itemcategory: "400", itemcode: "425", kindcode: "0"),
        ]),
        "건포도": ItemCategory(name: "건포도", codes: [
            ItemCode(itemcategory: "400", itemcode: "426", kindcode: "0"),
        ]),
        "건블루베리": ItemCategory(name: "건블루베리", codes: [
            ItemCode(itemcategory: "400", itemcode: "427", kindcode: "0"),
        ]),
        "망고": ItemCategory(name: "망고", codes: [
            ItemCode(itemcategory: "400", itemcode: "428", kindcode: "0"),
        ]),
        "블루베리": ItemCategory(name: "블루베리", codes: [
            ItemCode(itemcategory: "400", itemcode: "429", kindcode: "1"),
        ]),
        "아보카도": ItemCategory(name: "아보카도", codes: [
            ItemCode(itemcategory: "400", itemcode: "430", kindcode: "0"),
        ]),
        "고등어": ItemCategory(name: "고등어", codes: [
            ItemCode(itemcategory: "600", itemcode: "611", kindcode: "1"),
            ItemCode(itemcategory: "600", itemcode: "611", kindcode: "2"),
            ItemCode(itemcategory: "600", itemcode: "611", kindcode: "3"),
            ItemCode(itemcategory: "600", itemcode: "611", kindcode: "4"),
            ItemCode(itemcategory: "600", itemcode: "611", kindcode: "5"),
            ItemCode(itemcategory: "600", itemcode: "611", kindcode: "6"),
            ItemCode(itemcategory: "600", itemcode: "611", kindcode: "7"),
            ItemCode(itemcategory: "600", itemcode: "611", kindcode: "8"),
        ]),
        "꽁치": ItemCategory(name: "꽁치", codes: [
            ItemCode(itemcategory: "600", itemcode: "612", kindcode: "1"),
        ]),
        "갈치": ItemCategory(name: "갈치", codes: [
            ItemCode(itemcategory: "600", itemcode: "613", kindcode: "1"),
            ItemCode(itemcategory: "600", itemcode: "613", kindcode: "2"),
            ItemCode(itemcategory: "600", itemcode: "613", kindcode: "3"),
            ItemCode(itemcategory: "600", itemcode: "613", kindcode: "4"),
            ItemCode(itemcategory: "600", itemcode: "613", kindcode: "5"),
        ]),
        "조기": ItemCategory(name: "조기", codes: [
            ItemCode(itemcategory: "600", itemcode: "614", kindcode: "1"),
            ItemCode(itemcategory: "600", itemcode: "614", kindcode: "4"),
            ItemCode(itemcategory: "600", itemcode: "614", kindcode: "5"),
            ItemCode(itemcategory: "600", itemcode: "614", kindcode: "6"),
            ItemCode(itemcategory: "600", itemcode: "614", kindcode: "7"),
        ]),
        "명태": ItemCategory(name: "명태", codes: [
            ItemCode(itemcategory: "600", itemcode: "615", kindcode: "1"),
            ItemCode(itemcategory: "600", itemcode: "615", kindcode: "2"),
            ItemCode(itemcategory: "600", itemcode: "615", kindcode: "3"),
            ItemCode(itemcategory: "600", itemcode: "615", kindcode: "4"),
            ItemCode(itemcategory: "600", itemcode: "615", kindcode: "5"),
        ]),
        "삼치": ItemCategory(name: "삼치", codes: [
            ItemCode(itemcategory: "600", itemcode: "616", kindcode: "2"),
        ]),
        "물오징어": ItemCategory(name: "물오징어", codes: [
            ItemCode(itemcategory: "600", itemcode: "619", kindcode: "1"),
            ItemCode(itemcategory: "600", itemcode: "619", kindcode: "2"),
            ItemCode(itemcategory: "600", itemcode: "619", kindcode: "3"),
            ItemCode(itemcategory: "600", itemcode: "619", kindcode: "4"),
            ItemCode(itemcategory: "600", itemcode: "619", kindcode: "5"),
        ]),
        "건멸치": ItemCategory(name: "건멸치", codes: [
            ItemCode(itemcategory: "600", itemcode: "638", kindcode: "0"),
        ]),
        "북어": ItemCategory(name: "북어", codes: [
            ItemCode(itemcategory: "600", itemcode: "639", kindcode: "1"),
            ItemCode(itemcategory: "600", itemcode: "639", kindcode: "2"),
        ]),
        "건오징어": ItemCategory(name: "건오징어", codes: [
            ItemCode(itemcategory: "600", itemcode: "640", kindcode: "0"),
        ]),
        "김": ItemCategory(name: "김", codes: [
            ItemCode(itemcategory: "600", itemcode: "641", kindcode: "0"),
            ItemCode(itemcategory: "600", itemcode: "641", kindcode: "1"),
        ]),
        "건미역": ItemCategory(name: "건미역", codes: [
            ItemCode(itemcategory: "600", itemcode: "642", kindcode: "0"),
        ]),
        "굴": ItemCategory(name: "굴", codes: [
            ItemCode(itemcategory: "600", itemcode: "644", kindcode: "0"),
        ]),
        "수입조기": ItemCategory(name: "수입조기", codes: [
            ItemCode(itemcategory: "600", itemcode: "649", kindcode: "1"),
            ItemCode(itemcategory: "600", itemcode: "649", kindcode: "4"),
        ]),
        "새우젓": ItemCategory(name: "새우젓", codes: [
            ItemCode(itemcategory: "600", itemcode: "650", kindcode: "0"),
        ]),
        "멸치액젓": ItemCategory(name: "멸치액젓", codes: [
            ItemCode(itemcategory: "600", itemcode: "651", kindcode: "0"),
        ]),
        "굵은소금": ItemCategory(name: "굵은소금", codes: [
            ItemCode(itemcategory: "600", itemcode: "652", kindcode: "0"),
        ]),
        "전복": ItemCategory(name: "전복", codes: [
            ItemCode(itemcategory: "600", itemcode: "653", kindcode: "0"),
        ]),
        "새우": ItemCategory(name: "새우", codes: [
            ItemCode(itemcategory: "600", itemcode: "654", kindcode: "1"),
        ])
        ]
}
