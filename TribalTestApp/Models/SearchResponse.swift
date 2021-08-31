//
//  SearchResponse.swift
//  TribalTestApp
//
//  Created by Nelkit Chavez on 31/8/21.
//

import Foundation
import ObjectMapper

class SearchResponse: Mappable {
    var total:Int = 0
    var total_pages:Int = 0
    var results: Array<Photo> = Array<Photo>()
    
    required convenience init?(map: Map){
        self.init()
    }
    
    func mapping(map: Map) {
        total <- map["total"]
        total_pages <- map["total_pages"]
        results <- (map["results"], ArrayTransform<Photo>())
    }
}
