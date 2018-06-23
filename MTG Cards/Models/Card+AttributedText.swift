//
//  Card+AttributedText.swift
//  MTG Cards
//
//  Created by Eric Internicola on 6/23/18.
//  Copyright © 2018 Eric Internicola. All rights reserved.
//

import UIKit

extension Card {

    /// Takes the provided card metadata to build an attributed string.  If a set image is found
    /// for the provided card, then it's loaded into the beginning of the attributed string.  If
    /// not, then only the card name is provided back.
    ///
    /// - Parameter label: The label to read the bounds from
    /// - Returns: An attributed string with either the set image and card name, or just the card name.
    func cardSetAndName(for label: UILabel) -> NSAttributedString {
        guard let image = UIImage(named: set.lowercased() + ".svg") else {
            print("Set image could not be loaded for set: \(set)")
            return NSAttributedString(string: name)
        }

        let font = UIFont(name: "Chalkduster", size: 24) ?? UIFont.systemFont(ofSize: 24)

        let myShadow = NSShadow()
        myShadow.shadowBlurRadius = 3
        myShadow.shadowOffset = CGSize(width: 3, height: 3)
        myShadow.shadowColor = UIColor.gray

        let attributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.font: font,
            NSAttributedStringKey.shadow: myShadow
        ]

        return attributedTextwithImage(image: image, text: name, labelBound: label, attributes: attributes)
    }

    private func attributedTextwithImage(image: UIImage, text: String, labelBound: UILabel,
                                 attributes: [NSAttributedStringKey: Any]) -> NSAttributedString {
        let fullString = NSMutableAttributedString(string: "  ")
        let image1Attachment = NSTextAttachment()
        image1Attachment.bounds = CGRect(x: 0, y: ((labelBound.font.capHeight) - image.size.height).rounded() / 2,
                                         width: image.size.width, height: image.size.height)
        image1Attachment.bounds = CGRect(x: 0, y: 0, width: 25, height: 25)
        image1Attachment.image = image
        let image1String = NSAttributedString(attachment: image1Attachment)
        fullString.append(image1String)
        fullString.append(NSAttributedString(string: text, attributes: attributes))
        return fullString
    }
}
