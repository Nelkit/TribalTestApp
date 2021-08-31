//
//  FavoritesController.swift
//  TribalTestApp
//
//  Created by Nelkit Chavez on 31/8/21.
//

import UIKit

class FavoritesController: UIViewController {
    let localDB = RealmManager()
    @IBOutlet weak var favoritesCV: UICollectionView!
    var favoriteList = [Favorite]()
    let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let layout = favoritesCV?.collectionViewLayout as? DynamicLayout {
          layout.delegate = self
        }
        let nibCell = UINib(nibName: PhotoCell.reuseIdentifier, bundle: nil)
        favoritesCV.register(nibCell, forCellWithReuseIdentifier: PhotoCell.reuseIdentifier)
        favoritesCV.dataSource = self
        favoritesCV.delegate = self
        favoritesCV?.backgroundColor = .clear
        favoritesCV?.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
        
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Buscar "
        searchController.searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getLocalPhotos()
    }
    
    func getLocalPhotos() {
        let photos = Array<Favorite>(localDB.list(Favorite.self).sorted(by: { $0.date > $1.date }))
        favoriteList = photos
        favoritesCV.setEmptyMessage(lengthList: favoriteList.count, icon: #imageLiteral(resourceName: "favorites"), message: "Aún no has agregado fotos a tus favoritos",  withIcon: true)
        favoritesCV.reloadData()
    }
    
    func searchLocalPhotos(query: String) {
        let photos = Array<Favorite>(localDB.list(Favorite.self).filter("photo.user.name CONTAINS '\(query)' OR photo.user.username CONTAINS '\(query)'").sorted(by: { $0.date > $1.date }))
        favoriteList = photos
        favoritesCV.setEmptyMessage(lengthList: favoriteList.count, icon: #imageLiteral(resourceName: "favorites"), message: "Aún no has agregado fotos a tus favoritos",  withIcon: true)
        favoritesCV.reloadData()
    }
}

extension FavoritesController:UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        
        if  text.count > 3 {
            searchLocalPhotos(query: text)
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        getLocalPhotos()
    }
    
}

extension FavoritesController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseIdentifier, for: indexPath as IndexPath) as! PhotoCell
        cell.photo = favoriteList[indexPath.item].photo
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier:  "PhotoDetailController") as! PhotoDetailController
        vc.photo = favoriteList[indexPath.row].photo
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension FavoritesController: DynamicLayoutDelegate {
  func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath, cellWidth: CGFloat) -> CGFloat {
    
    if let photo = favoriteList[indexPath.row].photo{
        let imgHeight = Utility.calculateImageHeight(sourceImage: photo , scaledToWidth: cellWidth)
        return imgHeight
    }else{
        return 100
    }
  }
}

extension FavoritesController: PhotoDelegate{
    
    func didTapInProfile(user: User) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier:  "UserProfileController") as! UserProfileController
        vc.user = user

        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func didDeleteFavorite() {
        getLocalPhotos()
    }
}
