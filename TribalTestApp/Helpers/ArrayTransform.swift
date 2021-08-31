//
//  ArrayTransform.swift
//  TribalTestApp
//
//  Created by Nelkit Chavez on 31/8/21.
//

import UIKit
import ObjectMapper
import SwiftyJSON

class ArrayTransform<T:NSObject> : TransformType where T:Mappable {
    typealias Object = Array<T>
    typealias JSON = Array<AnyObject>
    let mapper = Mapper<T>()
    
    func transformFromJSON(_ value: Any?) -> Array<T>? {
        var result = Array<T>()
        if let tempArr = value as! Array<AnyObject>? {
            for entry in tempArr {
                let model : T = mapper.map(JSON: entry as! [String : Any])!
                result.append(model)
            }
        }
        return result
    }
    
    func transformToJSON(_ value: Object?) -> JSON? {
        var results = [AnyObject]()
        if let value = value {
            for obj in value {
                let json = mapper.toJSON(obj)
                results.append(json as AnyObject)
            }
        }
        return results
    }
}
