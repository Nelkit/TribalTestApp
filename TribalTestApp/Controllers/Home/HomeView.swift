//
//  HomeView.swift
//  TribalTestApp
//
//  Created by Nelkit Chavez on 30/8/21.
//

import Foundation

protocol HomeView {
    func retrievePhotos(photos: [Photo])
    func retrieveSearch(photos: [Photo])
}
