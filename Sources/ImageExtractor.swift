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
        let attributes = [convertFromNSAttributedStringKey(NSAttributedString.Key.font) : label.font]
        for char in text.characters {
            let charRect = String(char).boundingRect(with: CGSize(width: 0, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: convertToOptionalNSAttributedStringKeyDictionary(attributes as [String : Any]), context: nil)
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

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
	return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
