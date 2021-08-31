//
//  Favorite.swift
//  TribalTestApp
//
//  Created by Nelkit Chavez on 31/8/21.
//

import Foundation
import RealmSwift

class Favorite: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var date: Date = Date()
    @objc dynamic var photo: Photo?

    override class func primaryKey() -> String? {
      return "id"
    }
}
