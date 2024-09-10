//
//  CoreDataManager.swift
//  u_no
//
//  Created by t2023-m0117 on 9/8/24.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()

    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavoritesCoreData")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // 즐겨찾기 데이터 저장
    func saveFavoriteItem(name: String, price: String, discount: String, productno: String) {
        if isItemAlreadyFavorited(productno: productno) {
            print("Item with productno \(productno) already exists in favorites.")
            return
        }

        let favoriteItem = Favorites(context: context)
        favoriteItem.name = name
        favoriteItem.price = price
        favoriteItem.discount = discount
        favoriteItem.productno = productno
        
        do {
            try context.save()
            print("Favorite item saved: \(name)")
        } catch {
            print("Failed to save favorite item: \(error)")
        }
    }
    
    // 즐겨찾기 목록 불러오기
    func fetchFavoriteItems() -> [Favorites] {
        let fetchRequest: NSFetchRequest<Favorites> = Favorites.fetchRequest()
        
        do {
            let items = try CoreDataManager.shared.context.fetch(fetchRequest)
            print("\(fetchRequest)")
            return items
        } catch {
            print("Failed to fetch favorite items: \(error)")
            return []
        }
    }
    
    // 중복 항목 확인
    private func isItemAlreadyFavorited(productno: String) -> Bool {
        let fetchRequest: NSFetchRequest<Favorites> = Favorites.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "productno == %@", productno)
        
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Failed to check if item is already favorited: \(error)")
            return false
        }
    }
    
    // 즐겨찾기 항목 삭제
    func deleteFavoriteItem(productno: String) {
        let fetchRequest: NSFetchRequest<Favorites> = Favorites.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "productno == %@", productno)
        
        do {
            let items = try context.fetch(fetchRequest)
            if let itemToDelete = items.first {
                context.delete(itemToDelete)
                print("Favorite item deleted: \(productno)")
                try context.save()
            }
        } catch {
            print("Failed to delete favorite item: \(error)")
        }
    }
}
