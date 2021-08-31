//
//  NetworkHelper.swift
//  TribalTestApp
//
//  Created by Nelkit Chavez on 30/8/21.
//

import Foundation

class NetworkHelper: NSObject {

    
    class func checkResponse(statusCode:HTTPResponseCode, responseDict:[String:Any], url: String) -> ApiResponse  {
        switch statusCode {
        case .Success:
            let apiResponse = ApiResponse.init(status: true, data: responseDict, responseFor: .Default,message: responseDict["message"] as? String ?? "")
            
            
            apiResponse.statusCode = HTTPResponseCode.Success
            return  apiResponse
        default:
            let apiResponse = ApiResponse.init(status: false, data: responseDict, responseFor: .Default,message: responseDict["message"] as! String)
            apiResponse.statusCode = statusCode
            
            
            return apiResponse
        }
    }
}
