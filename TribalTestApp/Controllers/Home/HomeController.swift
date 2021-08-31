//
//  HomeController.swift
//  TribalTestApp
//
//  Created by Nelkit Chavez on 30/8/21.
//

import UIKit
import UIScrollView_InfiniteScroll


protocol PhotoDelegate: AnyObject {
    func didTapInProfile(user: User)
    func didDeleteFavorite()
}

class HomeController: UIViewController {
    @IBOutlet weak var photosCV: UICollectionView!
    var homePresenter: HomePresenter!
    var photoList = [Photo]()
    let localDB = RealmManager()
    var page = 1
    let searchController = UISearchController()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        photosCV.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        homePresenter = HomePresenter(homeService: HomeService())
        homePresenter?.attachView(view: self)
        homePresenter.getPhotos(page: page)
 
        
        if let layout = photosCV?.collectionViewLayout as? DynamicLayout {
          layout.delegate = self
        }
        let nibCell = UINib(nibName: PhotoCell.reuseIdentifier, bundle: nil)
        photosCV.register(nibCell, forCellWithReuseIdentifier: PhotoCell.reuseIdentifier)
        photosCV.dataSource = self
        photosCV.delegate = self
        photosCV?.backgroundColor = .clear
        photosCV?.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
        photosCV.addInfiniteScroll { [self] (collectionView) -> Void in
            homePresenter.getPhotos(page: page)
        }
        
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Buscar "
        searchController.searchBar.delegate = self
    }
}

extension HomeController:UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, text.count > 3 else { return }
        homePresenter.search(query: text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        photoList = []
        photosCV.reloadData()
        homePresenter.getPhotos(page: page)
    }
    
}


extension HomeController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseIdentifier, for: indexPath as IndexPath) as! PhotoCell
        cell.photo = photoList[indexPath.item]
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier:  "PhotoDetailController") as! PhotoDetailController
        vc.photo = photoList[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeController: HomeView{
    func retrieveSearch(photos: [Photo]) {
        photoList = []
        photoList = photos
        photosCV.reloadData()
        
        page = 1
    }
    
    func retrievePhotos(photos: [Photo]) {
        photoList.append(contentsOf: photos) 
        photosCV.reloadData()
        
        page += 1
        photosCV.finishInfiniteScroll()
    }
}

extension HomeController: DynamicLayoutDelegate {
  func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath, cellWidth: CGFloat) -> CGFloat {
    
    let imgHeight = Utility.calculateImageHeight(sourceImage: photoList[indexPath.row] , scaledToWidth: cellWidth)
    return imgHeight
  }
}

extension HomeController: PhotoDelegate{
    
    func didTapInProfile(user: User) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier:  "UserProfileController") as! UserProfileController
        vc.user = user

        self.navigationController?.pushViewController(vc, animated: true)
    }

    func didDeleteFavorite() {
        photosCV.reloadData()
    }
}
