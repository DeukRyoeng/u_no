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
    
    let items: Observable<[SectionModel<String, Product>]>
    
    init() {
        let top3Products = [
            Product(name: "복숭아", quantity: "10개", price: "23,021원", discount: "-20%"),
            Product(name: "부추", quantity: "1단", price: "5,816원", discount: "7.1%"),
            Product(name: "양파", quantity: "1kg", price: "6,981원", discount: "3.1%")
        ]
        
        let interestProducts = [
            Product(name: "쌀", quantity: "20kg", price: "51,816원", discount: ""),
            Product(name: "토마토", quantity: "1kg", price: "6,726원", discount: ""),
            Product(name: "고춧가루", quantity: "1kg", price: "35,268원", discount: ""),
            Product(name: "수박", quantity: "1개", price: "30,376원", discount: ""),
            Product(name: "김치", quantity: "1개", price: "35,151원", discount: ""),
            Product(name: "참외", quantity: "10개", price: "21,008원", discount: ""),
            Product(name: "삽겹살", quantity: "1kg", price: "35,268원", discount: ""),
            Product(name: "대파", quantity: "1kg", price: "15,268원", discount: "")
        ]
        
        let sections = [
            SectionModel(model: "Top3 Products", items: top3Products),
            SectionModel(model: "Interested Products", items: interestProducts)
        ]
        
        self.items = Observable.just(sections)
    }
}
