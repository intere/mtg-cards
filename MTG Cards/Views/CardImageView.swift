//
//  CardImageView.swift
//  MTG Cards
//
//  Created by Eric Internicola on 8/6/17.
//  Copyright © 2017 Eric Internicola. All rights reserved.
//

import UIKit

@IBDesignable
class CardImageView: UIImageView {

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable
    var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
        set {
            guard let newValue = newValue else {
                layer.borderColor = nil
                return
            }
            layer.borderColor = newValue.cgColor
        }
    }

    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            clipsToBounds = true
        }
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        borderWidth = 10
        borderColor = .black
        cornerRadius = 20
    }
}
