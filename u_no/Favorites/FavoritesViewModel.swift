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

    let items = BehaviorRelay<[FavoritesItem]>(value: [])
    let itemDeleted = PublishRelay<IndexPath>()
    
    private let disposeBag = DisposeBag()
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.coreDataManager = coreDataManager
    }
    
    func loadData() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            let favoriteItems = self.coreDataManager.fetchFavoriteItems()
            
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            numberFormatter.maximumFractionDigits = 0
            
            let favorites = favoriteItems.map { item in
                let priceWithoutDecimal = item.price?.split(separator: ".").first ?? "Unknown"
                let priceWithCurrency: String
                if let priceNumber = Int(priceWithoutDecimal),
                   let formattedPrice = numberFormatter.string(from: NSNumber(value: priceNumber)) {
                    priceWithCurrency = formattedPrice + "원"
                } else {
                    priceWithCurrency = "Unknown"
                }
                
                let discountWithPercentage = (item.discount ?? "Unknown") + "%"
                
                return FavoritesItem(
                    leftTopText: item.name ?? "Unknown",
                    rightTopText: priceWithCurrency,
                    rightBottomText: discountWithPercentage,
                    productno: item.productno ?? "Unknown" // Include productno
                )
            }
            
            DispatchQueue.main.async {
                self.items.accept(favorites)
                print("Loaded favorites: \(favorites)")
            }
        }
    }

    func deleteItem(at indexPath: IndexPath) {
        var currentItems = items.value
        guard indexPath.row < currentItems.count else { return }
        
        let productno = currentItems[indexPath.row].productno
        coreDataManager.deleteFavoriteItem(productno: productno)
        
        currentItems.remove(at: indexPath.row)
        items.accept(currentItems)
        itemDeleted.accept(indexPath)
    }
}
