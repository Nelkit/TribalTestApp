//
//  PhotoCell.swift
//  TribalTestApp
//
//  Created by Nelkit Chavez on 30/8/21.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    static let reuseIdentifier: String="PhotoCell"
    @IBOutlet weak var imageView: AsyncImage!
    @IBOutlet weak var profileView: CircleImage!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    let localDB = RealmManager()
    weak var delegate: PhotoDelegate?

    @IBOutlet weak var profileBottomContainer: Panel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileBottomContainer.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapProfileBottom)))
    }
    
    func setupUserCell() {
        profileBottomContainer.isHidden = true
    }
    
    @objc func tapProfileBottom() {
        if let photo = photo {
            if let user = photo.user, let delegate = delegate {
                delegate.didTapInProfile(user: user)
            }
        }
        
    }
    
    @IBAction func favoriteAction(_ sender: Any) {
        if let photo = photo {
            if let delegate = delegate {
                let favorites = localDB.list(Favorite.self).filter("id = '\(photo.id)'")

                if let favorite = favorites.first {
                    favoriteButton.setImage(#imageLiteral(resourceName: "like"), for: .normal)
                    localDB.delete(favorite)
                    delegate.didDeleteFavorite()
                }else{
                    favoriteButton.setImage(#imageLiteral(resourceName: "like_fill"), for: .normal)
                    let favorite = Favorite()
                    favorite.id = photo.id
                    favorite.photo = photo
                    favorite.date = Date()
                    localDB.save(favorite)
                }
                
            }
        }
    }
    
    var photo: Photo? {
      didSet {
        if let photo = photo {
            if let urls = photo.urls {
                imageView.loadAsyncFrom(url: urls.small, placeholder: #imageLiteral(resourceName: "image_placeholder_blank"))
            }
            if let user = photo.user, let imageProfile = user.profileImage?.medium {
                profileView.loadAsyncFrom(url: imageProfile, placeholder: #imageLiteral(resourceName: "image_placeholder_blank"))
                usernameLabel.text = user.name
            }
            
            likesLabel.text = "\(photo.likes) me gusta"
            
            let isFavorite = localDB.list(Favorite.self).filter("id = '\(photo.id)'").count == 1
            if isFavorite {
                favoriteButton.setImage(#imageLiteral(resourceName: "like_fill"), for: .normal)
            }else{
                favoriteButton.setImage(#imageLiteral(resourceName: "like"), for: .normal)
            }
        }
      }
    }
}

