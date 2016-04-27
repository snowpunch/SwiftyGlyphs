//  SpriteGlyphs.swift
//  Copyright © 2016 Woodie Dovich. <woodiewebsafe@gmail.com>
//  See MIT 'LICENSE' file distributed with this source code.
//
//  Converts a line of text into an array of SKSpriteNodes.
//  Individual characters can be richly animated with SKActions.
//  Requires an SKView surface.
//

import SpriteKit
import UIKit

public class SpriteGlyphs {
    
    var glyphs = [SKSpriteNode]()
    var scene = SKScene()
    var label = UILabel()
    var position = CGPointZero
    
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
    

    
    public func setLocation(skview:SKView, pos:CGPoint) {
        addToView(skview)
        layout(pos)
    }
    
    // Sprite co-ordinates are opposite on the Y axis. (0,0) is (left,bottom)
   public func layout(position:CGPoint) {
        self.position = position
        
        var spacing:CGFloat = position.x
        for glyph in glyphs {
            glyph.position = CGPoint(x: spacing,y: position.y)
            spacing += glyph.userData?["width"] as! CGFloat
            
            // also center for proper rotation animations.
            let posX = glyph.position.x + glyph.size.width / CGFloat(2.0)
            glyph.anchorPoint = CGPoint(x: 0.5,y: 0.5)
            glyph.position = CGPoint(x: posX, y: position.y)
            glyph.userData?["homeX"] = glyph.position.x
            glyph.userData?["homeY"] = glyph.position.y
        }
    }
    
    public func centerTextToView() {
        position.x = self.scene.size.width / 2.0 - getWidthOfText()/2.0
        layout(position)
    }
    
    public func getWidthOfText() -> CGFloat {
        var width:CGFloat = 0.0
        for glyph in glyphs {
            width += glyph.userData?["width"] as! CGFloat
        }
        return width
    }
    
    public func getSprites() -> [SKSpriteNode] {
        return glyphs
    }
    
    // you can pass in a nib or storyboard UIView that is customized to SKView.
    func addToView(skview:SKView ) {
        scene.scaleMode = .ResizeFill
        skview.backgroundColor = SKColor.clearColor()
        scene.backgroundColor = skview.backgroundColor!
        skview.presentScene(scene)
        for glyph in glyphs {
            scene.addChild(glyph)
        }
        skview.hidden = false
    }
    
    func generateGlyphs() {
        let images = ImageExtractor.getImages(label)
        for image in images {
            let sprite = SKSpriteNode(texture:SKTexture(image: image))
            sprite.userData = ["width":image.size.width]
            glyphs.append(sprite)
        }
    }
    
    func cleanup() {
        for glyph in glyphs {
            glyph.userData?.removeAllObjects()
            glyph.removeAllActions()
            glyph.removeFromParent()
        }
        glyphs.removeAll()
    }
    
    deinit {
        cleanup()
    }
}