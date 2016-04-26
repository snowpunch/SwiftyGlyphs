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
        let attributes = [NSFontAttributeName : label.font]
        for char in text.characters {
            let charRect = String(char).boundingRectWithSize(CGSizeMake(0, CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil)
            label.text = String(char)
            autoreleasepool {
                UIGraphicsBeginImageContextWithOptions(charRect.size, false, 2)
                label.drawTextInRect(charRect)
                let charImg = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                images.append(charImg)
            }
        }
        label.text = text
        return images
    }
}