//
//  Panel.swift
//  TribalTestApp
//
//  Created by Nelkit Chavez on 30/8/21.
//

import UIKit
import Foundation


/// Es una extension de UIView con mejoras por defecto como sombras, bordes redóndeados entre otros.
@IBDesignable
class Panel: UIView {
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    @IBInspectable var expandedSize: Bool = false
    
    override var intrinsicContentSize: CGSize {
        get {
            if expandedSize {
                return UIView.layoutFittingExpandedSize
            }else{
                let contentSize = super.intrinsicContentSize
                return contentSize
            }
        }
    }
    
    // MARK: - Lifecyle
    override open func awakeFromNib() {
        
    }
    
    /// Agrega el ancho del borde del view
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    
    /// Agrega el color del borde del view
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    /// Agregar un borde redóndeado al UIButton
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    /// Agrega una mascara de recorte cuando sea necesario
    @IBInspectable var overflowHidden: Bool = false {
        didSet {
            layer.masksToBounds = overflowHidden
        }
    }
    
    /// Agrega una sombra al view
    @IBInspectable var elevate: Double = 0 {
        didSet {
            self.setElevate(elevation: elevate, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1492627641))
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if #available(iOS 13.0, *) {
            layer.borderColor = borderColor?.resolvedColor(with: self.traitCollection).cgColor
        } else {
            // Fallback on earlier versions
        }
    }
    
    @IBInspectable var blurColor: UIColor? {
        didSet {
            guard let color = blurColor else { return }
            setBlurView(style: blurDarkStyle ? .dark : .light, color: color)
        }
    }
    
    @IBInspectable var blurDarkStyle: Bool = false {
        didSet {
            guard let color = blurColor else { return }
            setBlurView(style: blurDarkStyle ? .dark : .light, color: color)
        }
    }
    
    private func setBlurView(style: UIBlurEffect.Style = .light, color: UIColor =  UIColor(red: 1, green: 1, blue: 1, alpha: 0.8)) {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.backgroundColor = color
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.isUserInteractionEnabled = false
        self.insertSubview(blurEffectView, at: 0)
    }
}
