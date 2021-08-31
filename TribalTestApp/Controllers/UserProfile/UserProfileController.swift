//
//  UserProfileController.swift
//  TribalTestApp
//
//  Created by Nelkit Chavez on 31/8/21.
//

import UIKit
import UIScrollView_InfiniteScroll

class UserProfileController: UIViewController {
    @IBOutlet weak var profileImageView: CircleImage!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var totalPhotosLabel: UILabel!
    @IBOutlet weak var totalCollectionsLabel: UILabel!
    @IBOutlet weak var totalLikesLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!

    var user: User?

    var userProfilePresenter: UserProfilePresenter!
    
    @IBOutlet weak var photosCV: UICollectionView!
    var photoList = [Photo]()
    var page = 1
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        photosCV.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userProfilePresenter = UserProfilePresenter(userProfileService: UserProfileService())
        userProfilePresenter?.attachView(view: self)

        if let user = user, let imageProfile = user.profileImage?.large {
            profileImageView.loadAsyncFrom(url: imageProfile, placeholder: #imageLiteral(resourceName: "image_placeholder_blank"))
            usernameLabel.text = user.name
            
            totalPhotosLabel.text = "\(user.totalPhotos)"
            totalCollectionsLabel.text = "\(user.totalCollections)"
            totalLikesLabel.text = "\(user.totalLikes)"
            locationLabel.text = user.location
            
            
            userProfilePresenter.getPhotos(by: user.username, page: page)
        }
        

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
            guard let user = user else { return}
            userProfilePresenter.getPhotos(by: user.username, page: page)
        }
    }

}

extension UserProfileController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.reuseIdentifier, for: indexPath as IndexPath) as! PhotoCell
        cell.photo = photoList[indexPath.item]
        cell.setupUserCell()
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


extension UserProfileController: UserProfileView{
    func retrievePhotos(photos: [Photo]) {
        photoList.append(contentsOf: photos)
        photosCV.reloadData()
        
        page += 1
        photosCV.finishInfiniteScroll()
    }
}

extension UserProfileController: DynamicLayoutDelegate {
  func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath, cellWidth: CGFloat) -> CGFloat {
    
    let imgHeight = Utility.calculateImageHeight(sourceImage: photoList[indexPath.row] , scaledToWidth: cellWidth)
    return imgHeight
  }
}

extension UserProfileController: PhotoDelegate{
    
    func didTapInProfile(user: User) {}

    func didDeleteFavorite() {
        photosCV.reloadData()
    }
}
