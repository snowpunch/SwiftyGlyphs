//  SwiftyGlyphs.swift
//  Copyright © 2016 Woodie Dovich. <woodiewebsafe@gmail.com>
//  See MIT 'LICENSE' file distributed with this source code.
//
//  Light: No need for CoreText to animate individual characters.
//

import UIKit

public class SwiftyGlyphs {
    
    var glyphs = [Glyph]()
    public var label = UILabel()
    var view:UIView?
    var position = CGPoint.zero
    
    public init(fontName:String, size:CGFloat) {
        label.font = UIFont(name: fontName, size: size)
    }
    
    public var text:String? {
        get {
            guard let txt = label.text else { return nil }
            return txt
        }
        set (newVal) {
            label.text = newVal
            generateGlyphs()
        }
    }
    
    public func setLocation(view:UIView, pos:CGPoint) {
        addToView(view: view)
        layout(position: pos)
    }
    
    public func layout(position:CGPoint) {
        self.position = position
        var spacing:CGFloat = position.x
        for glyph in glyphs {
            glyph.position = CGPoint(x: spacing,y: position.y)
            spacing += glyph.width
            
            // also center for proper rotation animations.
            let posX = glyph.position.x + glyph.width / CGFloat(2.0)
            glyph.imgView.layer.anchorPoint = CGPoint(x: 0.5,y: 0.5)
            glyph.position = CGPoint(x: posX, y: position.y)
            glyph.imgView.center = glyph.position
        }
    }
    
    public func centerTextToView() {
        let viewWidth = view?.frame.size.width ?? 0
        position.x = viewWidth / 2.0 - getWidthOfText()/2.0
        layout(position: position)
    }
    
    public func getWidthOfText() -> CGFloat {
        var width:CGFloat = 0.0
        for glyph in glyphs {
            width += glyph.width
        }
        return width
    }
    
    public func getGlyphs() -> [Glyph] {
        return glyphs
    }
    
    func generateGlyphs() {
        let images = ImageExtractor.getImages(label: label)
        for image in images {
            let glyph = Glyph(img: image, width: image.size.width)
            glyphs.append(glyph)
        }
    }
    
    func addToView(view:UIView ) {
        self.view = view
        for glyph in glyphs {
            view.addSubview(glyph.imgView)
        }
    }
    
    func cleanup() {
        for glyph in glyphs {
            glyph.imgView.removeFromSuperview()
        }
        glyphs.removeAll()
    }
    
    deinit {
        cleanup()
    }
}
