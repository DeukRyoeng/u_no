//
//  Favorites+CoreDataProperties.swift
//  u_no
//
//  Created by t2023-m0117 on 9/8/24.
//
//

import Foundation
import CoreData


extension Favorites {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorites> {
        return NSFetchRequest<Favorites>(entityName: "Favorites")
    }
    @NSManaged public var productno: String?
}

extension Favorites : Identifiable {

}
