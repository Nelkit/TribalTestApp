//
//  NetworkHelper.swift
//  TribalTestApp
//
//  Created by Nelkit Chavez on 30/8/21.
//

import Foundation
import Alamofire

class NetworkHelper: NSObject {
    
    /// Header de Autenticación
    ///
    /// - Returns: valores para autenticación
    class func getAuthHeader() -> HTTPHeaders {
        // Authentication
        let auth: HTTPHeaders = ["Authorization" : "Client-ID \(Constants.unplashClientId)" ]
        
        return auth
    }

}
