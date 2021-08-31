//
//  ProfileImage.swift
//  TribalTestApp
//
//  Created by Nelkit Chavez on 30/8/21.
//

import Foundation
import ObjectMapper
import RealmSwift

class ProfileImage: Object,  Mappable {
    @objc dynamic var medium:String = ""
    @objc dynamic var small:String = ""
    @objc dynamic var large:String = ""
    
    required convenience init?(map: ObjectMapper.Map){
        self.init()
    }
    
    func mapping(map: ObjectMapper.Map) {
        medium <- map["medium"]
        small <- map["small"]
        large <- map["large"]
    }
}
