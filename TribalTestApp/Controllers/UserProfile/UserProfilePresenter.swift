//
//  UserProfilePresenter.swift
//  TribalTestApp
//
//  Created by Nelkit Chavez on 31/8/21.
//

import Foundation
import RxSwift
import RxCocoa
import RxAlamofire
import SwiftyJSON
import ObjectMapper

class UserProfilePresenter: BasePresenter {
    var disposeBag = DisposeBag()
    var getPhotosObservable: Disposable?

    typealias View = UserProfileView
    var userProfileView : UserProfileView?
    
    fileprivate let userProfileService : UserProfileService
    
    init(userProfileService: UserProfileService) {
        self.userProfileService = userProfileService
    }
    
    func attachView(view: UserProfileView) {
        self.userProfileView = view
    }
    
    func detachView() {
        self.userProfileView = nil
    }
    
    func destroy() {
        disposeBag = DisposeBag()
        getPhotosObservable?.dispose()
    }
    
    func getPhotos(by username: String, page: Int = 1)  {
        userProfileService.getPhotos(by: username, page: page)
        getPhotosObservable = userProfileService.rxGetPhotosResponse.subscribe(onNext: { (response) in
            if let photoList = Mapper<Photo>().mapArray(JSONObject: response){
                self.userProfileView?.retrievePhotos(photos: photoList)
            }
        }, onError: {(error) in

        }, onCompleted: {
            
        })
            
        getPhotosObservable?.disposed(by: disposeBag)
    }
}

