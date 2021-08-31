//
//  SearchReponse.swift
//  TribalTestApp
//
//  Created by Nelkit Chavez on 31/8/21.
//

import Foundation
import ObjectMapper

class SearchReponse: Mappable {
    @objc dynamic var total:Int = 0
    @objc dynamic var total_pages:Int = 0
    @objc dynamic var results:String = ""
    
    required convenience init?(map: Map){
        self.init()
    }
    
    func mapping(map: Map) {
        total <- map["total"]
        total_pages <- map["total_pages"]
        results <- map["results"]
    }
}
