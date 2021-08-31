//
//  AsyncImage.swift
//  TribalTestApp
//
//  Created by Nelkit Chavez on 30/8/21.
//

import Foundation
import UIKit
import Kingfisher

class AsyncImage: UIImageView {
    
    //MARK: - Public Methods
    
    struct CustomIndicator: Indicator {

        var activityView = UIActivityIndicatorView()
        
        var view: IndicatorView = UIView()
        
        func startAnimatingView() {
            activityView.startAnimating()
            view.isHidden = false
        }
        
        func stopAnimatingView() {
            activityView.stopAnimating()
            view.isHidden = true
        }
        
        init() {
            view.backgroundColor = .systemGray2
            view.addSubview(activityView)
            
            
            DispatchQueue.main.async(execute: { [self] in
                activityView.center = view.center
            })
        }
        
    }
    
    func loadAsyncFrom(url: String, placeholder: UIImage?, asThumbnail: Bool = false, thumbnailSize: CGSize = CGSize(width: 300, height: 300), onCompletion:@escaping (_ image: UIImage, _ url: URL)->(),onError:@escaping ()->()) {
        let url = URL(string: url)
        
        var options: KingfisherOptionsInfo = [
            .transition(.fade(1)),
            .diskCacheExpiration(StorageExpiration.days(15))
        ]
        
        if asThumbnail {
            options.append(.processor(DownsamplingImageProcessor(size: thumbnailSize)))
        }
        
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: placeholder,
            options: options,
            completionHandler:
                { [weak self] result in
                    guard self != nil else { return }
                    
                    switch result {
                    case .success(let value):
                        guard let urlImage = value.originalSource.url else { return }
                    
                        
                        onCompletion(value.image, urlImage)
                    case .failure(_):
                        onError()
                    }
                })
    }
    
    func loadAsyncFrom(url: String, placeholder: UIImage?, asThumbnail: Bool = false, thumbnailSize: CGSize = CGSize(width: 300, height: 300) ) {
        let url = URL(string: url)
        
        var options: KingfisherOptionsInfo = [
            .transition(.fade(1)),
            .diskCacheExpiration(StorageExpiration.days(15))
        ]
        
        if asThumbnail {
            options.append(.processor(DownsamplingImageProcessor(size: thumbnailSize)))
        }
        
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: placeholder,
            options: options
        )
    }
}


