//
//  Constants.swift
//  TribalTestApp
//
//  Created by Nelkit Chavez on 30/8/21.
//

import Foundation

class Constants {
    static let apiBase = "https://api.unsplash.com"
    static let unplashClientId = "NVUFe86BIxWY7PdxaH8SLCADgmuB52jbxs60F4gDHv4"
}

enum HTTPResponseCode: Int {
    case Success = 200
    case BadRequest = 400
    case Unauthorized = 401
    case Forbidden = 403
    case NotFound = 404
}


