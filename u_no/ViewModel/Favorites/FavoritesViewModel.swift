//
//  FavoritesViewModel.swift
//  u_no
//
//  Created by t2023-m0117 on 9/2/24.
//

import UIKit
import RxSwift
import RxCocoa

class FavoritesViewModel {
    // Input: Data
    let items = BehaviorRelay<[FavoritesItem]>(value: [])
    
    // Output: Actions
    let itemDeleted = PublishRelay<IndexPath>()
    
    private let disposeBag = DisposeBag()
    
    init() {
        setupInitialData()
    }
    
    private func setupInitialData() {
        let initialItems = [
            FavoritesItem(leftTopText: "복숭아", rightTopText: "23,021원", rightBottomText: "20%"),
            FavoritesItem(leftTopText: "쌀", rightTopText: "51,816원", rightBottomText: "0%"),
            FavoritesItem(leftTopText: "당근", rightTopText: "6,981원", rightBottomText: "3.13%")
        ]
        items.accept(initialItems)
    }
    
    func deleteItem(at indexPath: IndexPath) {
        var currentItems = items.value
        guard indexPath.row < currentItems.count else { return }
        currentItems.remove(at: indexPath.row)
        items.accept(currentItems)
        itemDeleted.accept(indexPath)
    }
}
