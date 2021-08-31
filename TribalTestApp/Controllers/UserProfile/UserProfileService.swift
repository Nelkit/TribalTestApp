//
//  UserProfileService.swift
//  TribalTestApp
//
//  Created by Nelkit Chavez on 31/8/21.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift
import SwiftyJSON


class UserProfileService {
    let rxGetPhotosResponse = PublishSubject<Array<Any>>()
    let disposeBag = DisposeBag()

    func getPhotos(by username: String, page: Int) {
        
        let url = "\(Constants.apiBase)/users/\(username)/photos?page=\(page)"
        
        RxAlamofire
            .requestJSON(.get,
                                url,
                                parameters: nil,
                                encoding: JSONEncoding.default,
                                headers: NetworkHelper.getAuthHeader())
            //.debug()
            .subscribe(onNext: { (headerResponse, json) in
                let jsonData = JSON(json)
                let statusCode:HTTPResponseCode = HTTPResponseCode.init(rawValue: headerResponse.statusCode)!
                switch(statusCode){
                    case .Success:
                        if let dict = jsonData.arrayObject {
                            self.rxGetPhotosResponse.onNext(dict)
                        }
                        break
                    case .BadRequest,  .Forbidden, .NotFound:
                        break
                    case .Unauthorized:
                        break
                }
        }, onError: {  (error) in
            self.rxGetPhotosResponse.onError(error)
        }, onDisposed: {
            
        }).disposed(by: disposeBag)
    }
}
