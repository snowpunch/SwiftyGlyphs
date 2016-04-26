//  SwiftyGlyphs.swift
//  Copyright © 2016 Woodie Dovich. <woodiewebsafe@gmail.com>
//  See MIT 'LICENSE' file distributed with this source code.
//
//  Light: No need for CoreText to animate individual characters.
//

import UIKit

public class SwiftyGlyphs {
    
    private var glyphs = [Glyph]()
    var label = UILabel()
    var view:UIView?
    var position = CGPointZero
    
    init(fontName:String, size:CGFloat) {
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
    
    func generateGlyphs() {
        let images = ImageExtractor.getImages(label)
        for image in images {
            let glyph = Glyph(img: image, width: image.size.width)
            glyphs.append(glyph)
        }
    }
    
    func setLocation(view:UIView, pos:CGPoint) {
        addToView(view)
        layout(pos)
    }
    
    func addToView(view:UIView ) {
        self.view = view
        for glyph in glyphs {
            view.addSubview(glyph.imgView)
        }
    }
    
    func layout(position:CGPoint) {
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
    
    func centerTextToView() {
        let viewWidth = view?.frame.size.width ?? 0
        position.x = viewWidth / 2.0 - getWidthOfText()/2.0
        layout(position)
    }
    
    func getWidthOfText() -> CGFloat {
        var width:CGFloat = 0.0
        for glyph in glyphs {
            width += glyph.width
        }
        return width
    }
    
    func getGlyphs() -> [Glyph] {
        return glyphs
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
