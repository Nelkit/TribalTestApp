//
//  HomePresenter.swift
//  TribalTestApp
//
//  Created by Nelkit Chavez on 30/8/21.
//
import Foundation
import RxSwift
import RxCocoa
import RxAlamofire
import SwiftyJSON
import ObjectMapper

class HomePresenter: BasePresenter {
    var disposeBag = DisposeBag()
    var getPhotosObservable: Disposable?
    var searchObservable: Disposable?

    typealias View = HomeView
    var homeView : HomeView?
    
    fileprivate let homeService : HomeService
    
    init(homeService: HomeService) {
        self.homeService = homeService
    }
    
    func attachView(view: HomeView) {
        self.homeView = view
    }
    
    func detachView() {
        self.homeView = nil
    }
    
    func destroy() {
        disposeBag = DisposeBag()
        getPhotosObservable?.dispose()
        searchObservable?.dispose()
    }
    
    func getPhotos(page: Int = 1)  {
        homeService.getPhotos(page: page)
        
        if !homeService.rxGetPhotosResponse.hasObservers {
            getPhotosObservable = homeService.rxGetPhotosResponse.subscribe(onNext: { (response) in
                if let photoList = Mapper<Photo>().mapArray(JSONObject: response){
                    self.homeView?.retrievePhotos(photos: photoList)
                }
            }, onError: {(error) in

            }, onCompleted: {

            })
                
            getPhotosObservable?.disposed(by: disposeBag)
        }
    }
    
    func search(query:String, page: Int = 1)  {
        homeService.search(query: query, page: page)
        
        if !homeService.rxSearchPhotosResponse.hasObservers {
            searchObservable = homeService.rxSearchPhotosResponse.subscribe(onNext: { (response) in
                if let searchResponse = Mapper<SearchResponse>().map(JSONObject: response){
                    self.homeView?.retrieveSearch(photos: searchResponse.results)
                }
            }, onError: {(error) in

            }, onCompleted: {
         
            })
                
            searchObservable?.disposed(by: disposeBag)
        }

    }
}
