//
//  CircleImage.swift
//  TribalTestApp
//
//  Created by Nelkit Chavez on 31/8/21.
//

import UIKit
import Foundation

@IBDesignable
class CircleImage: AsyncImage {
    
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var circleImage: Bool = true {
        didSet {
            self.layer.masksToBounds = true
            self.layer.cornerRadius = self.bounds.size.width / 2
        }
    }
    
    override var bounds: CGRect{
        didSet{
            self.layer.masksToBounds = true
            self.layer.cornerRadius = self.bounds.size.width / 2
        }
    }
    
    override var isHighlighted: Bool{
        didSet{
            if isHighlighted{
                UIView.animate(withDuration: 0.3, animations: {
                    self.transform = CGAffineTransform.identity.scaledBy(x: 0.96, y: 0.96)
                })
            }else{
                UIView.animate(withDuration: 0.3, animations: {
                    self.transform = CGAffineTransform.identity
                })
            }
        }
    }
}


