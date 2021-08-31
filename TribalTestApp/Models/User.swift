//
//  User.swift
//  TribalTestApp
//
//  Created by Nelkit Chavez on 30/8/21.
//

import Foundation
import ObjectMapper
import RealmSwift

class User: Object, Mappable {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var username: String = ""
    @objc dynamic var totalCollections: Int = 0
    @objc dynamic var totalLikes: Int = 0
    @objc dynamic var totalPhotos: Int = 0
    @objc dynamic var location: String = ""
    @objc dynamic var profileImage: ProfileImage?
    @objc dynamic var social: Social?

    override class func primaryKey() -> String? {
      return "id"
    }
    
    required convenience init?(map: ObjectMapper.Map){
        self.init()
    }
    
    func mapping(map: ObjectMapper.Map) {
        id <- map["id"]
        name <- map["name"]
        username <- map["username"]
        totalCollections <- map["total_collections"]
        totalLikes <- map["total_likes"]
        totalPhotos <- map["total_photos"]
        location <- map["location"]
        profileImage <- map["profile_image"]
        social <- map["social"]
    }
}
