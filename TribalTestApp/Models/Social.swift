//
//  Social.swift
//  TribalTestApp
//
//  Created by Nelkit Chavez on 31/8/21.
//
import Foundation
import ObjectMapper
import RealmSwift

class Social: Object, Mappable {
    @objc dynamic var instagramUsername:String = ""
    @objc dynamic var portfolioUrl:String = ""
    @objc dynamic var twitterUsername:String = ""
    
    required convenience init?(map: ObjectMapper.Map){
        self.init()
    }
    
    func mapping(map: ObjectMapper.Map) {
        instagramUsername <- map["instagram_username"]
        portfolioUrl <- map["portfolio_url"]
        twitterUsername <- map["twitter_username"]
    }
}
