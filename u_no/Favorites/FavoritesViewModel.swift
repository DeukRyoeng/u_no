//
//  FavoritesViewModel.swift
//  u_no
//
//  Created by t2023-m0117 on 9/2/24.
//

import Foundation
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
        let favoriteItems = CoreDataManager.shared.fetchFavoriteItems()
        
        // NumberFormatter 설정
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0 // 소수점 제거
        
        let favorites = favoriteItems.map { item in
            // 가격 값을 숫자로 변환하고, 3자리마다 콤마를 추가
            let priceWithoutDecimal = item.price?.split(separator: ".").first ?? "Unknown"
            if let priceNumber = Int(priceWithoutDecimal), let formattedPrice = numberFormatter.string(from: NSNumber(value: priceNumber)) {
                let priceWithCurrency = formattedPrice + "원"
                
                return FavoritesItem(leftTopText: item.name ?? "Unknown",
                                     rightTopText: priceWithCurrency,
                                     rightBottomText: item.discount ?? "Unknown")
            } else {
                return FavoritesItem(leftTopText: item.name ?? "Unknown",
                                     rightTopText: "Unknown",
                                     rightBottomText: item.discount ?? "Unknown")
            }
        }
        
        items.accept(favorites)
        print("Loaded favorites: \(favorites)") // 데이터 로깅
    }

    func deleteItem(at indexPath: IndexPath) {
        var currentItems = items.value
        guard indexPath.row < currentItems.count else { return }
        currentItems.remove(at: indexPath.row)
        items.accept(currentItems)
        itemDeleted.accept(indexPath)
    }
}
