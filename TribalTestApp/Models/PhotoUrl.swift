//
//  PhotoUrl.swift
//  TribalTestApp
//
//  Created by Nelkit Chavez on 30/8/21.
//

import Foundation
import ObjectMapper
import RealmSwift

class PhotoUrl: Object, Mappable {
    @objc dynamic var raw:String = ""
    @objc dynamic var full:String = ""
    @objc dynamic var regular:String = ""
    @objc dynamic var small:String = ""
    @objc dynamic var thumb:String = ""
    
    required convenience init?(map: ObjectMapper.Map){
        self.init()
    }
    
    func mapping(map: ObjectMapper.Map) {
        raw <- map["raw"]
        full <- map["full"]
        regular <- map["regular"]
        small <- map["small"]
        thumb <- map["thumb"]
    }
}
