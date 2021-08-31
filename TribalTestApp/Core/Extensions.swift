//
//  Extensions.swift
//  TribalTestApp
//
//  Created by Nelkit Chavez on 30/8/21.
//

import UIKit
import Foundation

// MARK: UIView Extensions
extension UIView {
    /**
     Agrega una Sombra al UIView
     - Parameters:
     - elevation : pasar un valor de 1 a n para poder determinar que tan pronunciada sera la sombra.
     - color: pasar un UIColor para detrminar que color tendra la sombra.
     
     ### Usage Example: ###
     ````
     setElevate(elevation: 1, color: UIColor.black)
     ````
     */
    func setElevate(elevation:Double, color: UIColor = UIColor.colorWithHexString(hex: "#000000", alpha: 0.2)){
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: elevation)
        self.layer.shadowRadius = CGFloat(elevation == 0 ? 0 : 6)
        self.layer.shadowOpacity = 1
    }
    
    /**
     Agrega una Sombra al UIView
     - Parameters:
     - elevation : pasar un valor de 1 a n para poder determinar que tan pronunciada sera la sombra.
     - color: pasar un UIColor para detrminar que color tendra la sombra.
     
     ### Usage Example: ###
     ````
     setElevate(elevation: 1, color: UIColor.black)
     ````
     */
    func setElevate(elevation:Double, width: Double, height: Double, color: UIColor){
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: width, height: height)
        self.layer.shadowRadius = CGFloat(elevation == 0 ? 0 : 6)
        self.layer.shadowOpacity = 1
    }
    
    func removeAllShadows() {
        if let sublayers = self.layer.sublayers, !sublayers.isEmpty {
            for sublayer in sublayers {
                sublayer.removeFromSuperlayer()
            }
        }
    }
    
    func setBlur(style: UIBlurEffect.Style = .light, color: UIColor =  UIColor(red: 1, green: 1, blue: 1, alpha: 0.7)) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.backgroundColor = color
        blurEffectView.layer.cornerRadius = 5
        blurEffectView.layer.masksToBounds = true
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
        self.sendSubviewToBack(blurEffectView)
    }
}

extension UIColor {
    
    static func colorWithHexString (hex:String, alpha: CGFloat = 1.0) -> UIColor {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        return self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                         green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                         blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                         alpha: alpha)
    }

}

// MARK: UITableView Extensions
extension UICollectionView {
    ///Elimina las filas que se encuentren vacías
    func setEmptyMessage(lengthList: Int, icon: UIImage = #imageLiteral(resourceName: "image_placeholder_blank"), message: String = "", withIcon:Bool = false, iconSize: CGSize = CGSize(width: 150, height: 150)) {
        let wrapper: UIStackView = UIStackView()
        let container: UIStackView = UIStackView()
        let iconView: UIImageView = UIImageView()
        let messageLabel: UILabel = UILabel()
        
        if lengthList == 0 {
            messageLabel.frame = self.frame
            messageLabel.textColor = UIColor.label
            messageLabel.font = UIFont.boldSystemFont(ofSize: 18)
            messageLabel.textAlignment = .center
            messageLabel.numberOfLines = 0
            messageLabel.text = message
            
            iconView.image = icon
            iconView.isHidden = true
            
            container.axis = .vertical
            container.alignment = .center
            container.distribution = .fill
            container.spacing = 10
            container.addArrangedSubview(iconView)
            container.addArrangedSubview(messageLabel)
            
            wrapper.axis = .horizontal
            wrapper.alignment = .center
            wrapper.distribution = .fill
            wrapper.addArrangedSubview(container)
            
            for view in [messageLabel, iconView]{
                view.translatesAutoresizingMaskIntoConstraints = false
            }
            
            messageLabel.widthAnchor.constraint(equalToConstant: 280).isActive = true
            
            iconView.heightAnchor.constraint(equalToConstant: iconSize.height).isActive = true
            iconView.widthAnchor.constraint(equalToConstant: iconSize.width).isActive = true
            
            if withIcon{
                iconView.isHidden = false
            }
        
            
            self.backgroundView = wrapper
        }else{
            self.backgroundView = nil
        }
    }
}
