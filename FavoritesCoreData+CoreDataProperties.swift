//
//  FavoritesCoreData+CoreDataProperties.swift
//  u_no
//
//  Created by t2023-m0117 on 9/7/24.
//
//

import Foundation
import CoreData


extension FavoritesCoreData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritesCoreData> {
        return NSFetchRequest<FavoritesCoreData>(entityName: "FavoritesCoreData")
    }

    @NSManaged public var name: String?
    @NSManaged public var price: String?
    @NSManaged public var directions: String?

}

extension FavoritesCoreData : Identifiable {

}
