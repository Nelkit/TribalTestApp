//
//  PhotoDetailController.swift
//  TribalTestApp
//
//  Created by Nelkit Chavez on 31/8/21.
//

import UIKit

class PhotoDetailController: UIViewController {
    @IBOutlet weak var mainImageView: AsyncImage!
    @IBOutlet weak var profileImageView: CircleImage!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var descripLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dimensionLabel: UILabel!
    @IBOutlet weak var userBox: Panel!
    
    var photo: Photo?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let photo = photo {
            if let urls = photo.urls {
                mainImageView.loadAsyncFrom(url: urls.full, placeholder: #imageLiteral(resourceName: "image_placeholder_blank"))
            }
            if let user = photo.user, let imageProfile = user.profileImage?.large {
                profileImageView.loadAsyncFrom(url: imageProfile, placeholder: #imageLiteral(resourceName: "image_placeholder_blank"))
                usernameLabel.text = user.name
            }
            
            likesLabel.text = "\(photo.likes) me gusta"
            descripLabel.text = photo.descrip.count > 0 ? photo.descrip : "-"
            dateLabel.text = Utility.formatDateAndHourBy(dateStr: photo.created_at) 
            dimensionLabel.text = "\(photo.width) x \(photo.height) "
            
            let imgHeight = Utility.calculateImageHeight(sourceImage: photo , scaledToWidth: UIScreen.main.bounds.width)
            imageHeightConstraint.constant = imgHeight
        }
        
        userBox.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToProfileAction)))
    }
    
    @objc func goToProfileAction(){
        if let photo = photo {
            let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let vc = storyboard.instantiateViewController(withIdentifier:  "UserProfileController") as! UserProfileController
            vc.user = photo.user

            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func closeAction(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
}
