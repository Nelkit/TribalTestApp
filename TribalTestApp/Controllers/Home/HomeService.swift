//
//  HomeService.swift
//  TribalTestApp
//
//  Created by Nelkit Chavez on 30/8/21.
//

import Foundation
import Alamofire
import RxAlamofire
import RxSwift
import SwiftyJSON


class HomeService {
    let rxGetPhotosResponse = PublishSubject<Array<Any>>()
    let rxSearchPhotosResponse = PublishSubject<[String:Any]>()
    let disposeBag = DisposeBag()

    func getPhotos(page: Int = 1) {
        
        let url = "\(Constants.apiBase)/photos?page=\(page)"
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
    
    func search(query:String, page: Int = 1) {
        let url = "\(Constants.apiBase)/search/photos?query=\(query)"
        guard var urlString = url.addingPercentEncoding(withAllowedCharacters:.urlQueryAllowed) else{ return }
        urlString = urlString.replacingOccurrences(of: "%2520", with: "+")
        
       
        RxAlamofire
            .requestJSON(.get,
                         urlString,
                                parameters: nil,
                                encoding: JSONEncoding.default,
                                headers: NetworkHelper.getAuthHeader())
            .debug()
            .subscribe(onNext: { (headerResponse, json) in
                let jsonData = JSON(json)
                let statusCode:HTTPResponseCode = HTTPResponseCode.init(rawValue: headerResponse.statusCode)!
                switch(statusCode){
                    case .Success:
                        if let dict = jsonData.dictionaryObject {
                            self.rxSearchPhotosResponse.onNext(dict)
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
    
