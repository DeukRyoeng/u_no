//
//  CoreDataManager.swift
//  u_no
//
//  Created by t2023-m0117 on 9/7/24.
//

import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavoritesData")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // 저장 메서드
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    // CREATE: 즐겨찾기 항목 추가
    func createFavorite(name: String, price: String, directions: String) {
        let newFavorite = FavoritesCoreData(context: context)
        newFavorite.name = name
        newFavorite.price = price
        newFavorite.directions = directions
        saveContext() // 변경 사항 저장
    }
    
    // READ: 저장된 즐겨찾기 항목 가져오기
    func fetchFavorites() -> [FavoritesCoreData] {
        let fetchRequest: NSFetchRequest<FavoritesCoreData> = FavoritesCoreData.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch favorites: \(error)")
            return []
        }
    }
    
    // UPDATE: 즐겨찾기 항목 업데이트
    func updateFavorite(_ favorite: FavoritesCoreData, newName: String, newPrice: String, newDirections: String) {
        favorite.name = newName
        favorite.price = newPrice
        favorite.directions = newDirections
        saveContext() // 변경 사항 저장
    }

    // DELETE: 즐겨찾기 항목 삭제
    func deleteFavorite(_ favorite: FavoritesCoreData) {
        context.delete(favorite)
        saveContext()
    }
}
