//
//  FavoritesViewModel.swift
//  u_no
//
//  Created by t2023-m0117 on 9/2/24.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

class FavoritesViewModel {

    let items = BehaviorRelay<[FavoritesItem]>(value: [])
    let favoritePrices = BehaviorRelay<[Price]>(value: [])
    let itemDeleted = PublishRelay<IndexPath>()
    
    private let disposeBag = DisposeBag()
    private let coreDataManager: CoreDataManager
    private let network = NetworkManager.shared

    init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.coreDataManager = coreDataManager
    }
    
    func loadData() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            let favoriteItems = self?.coreDataManager.fetchFavoriteItems() ?? []
            let productNos = favoriteItems.compactMap { $0.productno }
            
            self?.fetchFavoriteItems(productNos: productNos)
        }
    }

    func fetchFavoriteItems(productNos: [String]) {
        let endpoint = Endpoint(
            baseURL: "https://www.kamis.or.kr",
            path: "/service/price/xml.do",
            queryParameters: [
                "p_cert_key": "5845f7c3-4274-41a7-a88a-c79efefe21dc",
                "action": "dailySalesList",
                "p_cert_id": "4710",
                "p_returntype": "json"
            ])
        
        network.fetch(endpoint: endpoint)
            .map { (result: Foodprices) in
                result.price.filter { price in
                    productNos.contains(price.productno ?? "")
                }
            }
            .subscribe(onSuccess: { [weak self] (favoriteItems: [Price]) in
                self?.favoritePrices.accept(favoriteItems)
                
                let updatedItems = favoriteItems.map { price in
                    // Determine the direction sign, color, and price color
                    let directionSign: String
                    let directionColor: UIColor
                    let priceColor: UIColor
                    let direction = price.direction.asString()
                    let value = price.value.asString()
                    
                    switch direction {
                    case "0": // Price dropped
                        directionSign = "-\(value)"
                        directionColor = UIColor.mainBlue
                        priceColor = UIColor.mainBlue
                    case "1": // Price increased
                        directionSign = "+\(value)"
                        directionColor = UIColor.mainRed
                        priceColor = UIColor.mainRed
                    case "2": // No change
                        directionSign = "\(value)"
                        directionColor = .black
                        priceColor = .black
                    default:
                        directionSign = "\(value)"
                        directionColor = .black
                        priceColor = .black
                    }
                    
                    return FavoritesItem(leftTopText: price.productName ?? "",
                                          rightTopText: "\(price.dpr1.asString())원",
                                          rightBottomText: "\(directionSign)%",
                                          productno: price.productno ?? "",
                                          priceColor: priceColor,
                                          fluctuationColor: directionColor)
                }
                self?.items.accept(updatedItems)
            }, onFailure: { error in
                print("Error fetching favorite items: \(error)")
            }).disposed(by: disposeBag)
    }

    func deleteItem(at indexPath: IndexPath) {
        let itemToDelete = items.value[indexPath.row]
        guard let productno = itemToDelete.productno else { return }
        
        // Delete from Core Data
        coreDataManager.deleteFavoriteItem(productno: productno)
        
        // Remove from items array
        var currentItems = items.value
        currentItems.remove(at: indexPath.row)
        items.accept(currentItems)
        
        // Optionally, update favoritePrices if needed
        // var currentPrices = favoritePrices.value
        // currentPrices.removeAll { $0.productno == productno }
        // favoritePrices.accept(currentPrices)
        
        itemDeleted.accept(indexPath) // Notify that an item was deleted
    }
}
