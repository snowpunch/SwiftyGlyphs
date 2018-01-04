//  ImageExtractor.swift
//  Copyright © 2016 Woodie Dovich. <woodiewebsafe@gmail.com>
//  See MIT 'LICENSE' file distributed with this source code.
//
//  Extracts font images from a temporary non-visible UILabel.
//

import UIKit

public class ImageExtractor {
    
    class func getImages(label:UILabel) -> [UIImage] {
        var images = [UIImage]()
        let text = label.text ?? "no text"
        let attributes = [NSAttributedStringKey.font : label.font]
        for char in text.characters {
            let charRect = String(char).boundingRect(with: CGSize(width: 0, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes, context: nil)
            label.text = String(char)
            autoreleasepool {
                UIGraphicsBeginImageContextWithOptions(charRect.size, false, 2)
                label.drawText(in: charRect)
                let charImg = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                images.append(charImg!)
            }
        }
        label.text = text
        return images
    }
}
