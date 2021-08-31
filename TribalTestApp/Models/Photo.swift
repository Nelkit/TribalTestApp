//
//  Photo.swift
//  TribalTestApp
//
//  Created by Nelkit Chavez on 30/8/21.
//

import Foundation
import ObjectMapper
import RealmSwift

class Photo: Object, Mappable {
    @objc dynamic var id: String = ""
    @objc dynamic var descrip: String = ""
    @objc dynamic var created_at: String = ""
    @objc dynamic var height: Int = 0
    @objc dynamic var width: Int = 0
    @objc dynamic var likes: Int = 0
    @objc dynamic var urls: PhotoUrl?
    @objc dynamic var user: User?

    override class func primaryKey() -> String? {
      return "id"
    }
    
    required convenience init?(map: ObjectMapper.Map){
        self.init()
    }
    
    func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        descrip <- map["descrip"]
        created_at <- map["created_at"]
        height <- map["height"]
        width <- map["width"]
        likes <- map["likes"]
        urls <- map["urls"]
        user <- map["user"]
    }
}

