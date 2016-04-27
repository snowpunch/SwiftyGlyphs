# SwiftyGlyphs

[![Version](https://img.shields.io/cocoapods/v/SwiftyGlyphs.svg?style=flat)](http://cocoapods.org/pods/SwiftyGlyphs)
[![License](https://img.shields.io/cocoapods/l/SwiftyGlyphs.svg?style=flat)](http://cocoapods.org/pods/SwiftyGlyphs)
[![Platform](https://img.shields.io/cocoapods/p/SwiftyGlyphs.svg?style=flat)](http://cocoapods.org/pods/SwiftyGlyphs)

## Features
- Dynamically generated character assets.
- Preserves font color, style and spacing as individual transparent png's.
- Option to generate SKSpriteNode glyphs instead for SKActions.

## Usage

Animate an array of characters.  (working example)

```swift
import UIKit
import SwiftyGlyphs

class ViewController: UIViewController {
   var swiftyLabel = SwiftyGlyphs(fontName: "MarkerFelt-Wide", size:24)

   override func viewDidAppear(animated: Bool) {
      super.viewDidAppear(animated)

      swiftyLabel.text = "SwiftyGlyphs!"
      swiftyLabel.setLocation(self.view, pos: CGPoint(x:0,y:100))
      swiftyLabel.centerTextToView()

      exampleAnimation(swiftyLabel.getGlyphs())
   }

   func exampleAnimation(glyphs:[Glyph]) {
      var delay = 1.0
      for glyph in glyphs {
         UIView.animateWithDuration(0.5, delay: delay, options: [.Repeat, .CurveEaseInOut, .Autoreverse], animations: {
            glyph.imgView.center.y = 140
            glyph.imgView.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI))
         }, completion: nil)
         delay += 0.01
     }
   }
}
```

## SpriteKit example

With this example I added a UIView to storyboard UIViewController and then customized it in the side panel as an SKView. 

```swift
import UIKit
import SpriteKit
import SwiftyGlyphs

class ViewController: UIViewController {

   @IBOutlet weak var skview: SKView!
   var spriteLabel = SpriteGlyphs(fontName: "Copperplate-Light", size:24)

   override func viewDidAppear(animated: Bool) {
      super.viewDidAppear(animated)

      spriteLabel.text = "SpriteKit Baby!!"
      spriteLabel.setLocation(skview, pos: CGPoint(x:0,y:30))
      spriteLabel.centerTextToView()

      spriteKitAnimation(spriteLabel)
   }

   func spriteKitAnimation(glyphSprites:SpriteGlyphs) {
      let sprites = glyphSprites.getSprites()

      let moveSeq = SKAction.sequence([
         SKAction.moveBy(CGVector(dx:30,dy:0), duration: 0.3),
         SKAction.moveBy(CGVector(dx:0,dy:30), duration: 0.5),
         SKAction.moveBy(CGVector(dx:-30,dy:0), duration: 0.2),
         SKAction.moveBy(CGVector(dx:0,dy:-30), duration: 0.3),
         SKAction.moveBy(CGVector(dx:0,dy:30), duration: 0.3),
         SKAction.moveBy(CGVector(dx:0,dy:-30), duration: 0.4),
      ])
      moveSeq.timingMode = .EaseIn

      let rotationSeq = SKAction.sequence([
         SKAction.rotateToAngle(CGFloat(M_PI), duration: 1),
         SKAction.rotateToAngle(0, duration: 2.3),
      ])
      rotationSeq.timingFunction = snappyEaseOut

      var delay = 0.0
      for glyph in sprites {
         let delaySeq = SKAction.sequence([Act.waitForDuration(delay),rotationSeq])
         let group = SKAction.group([moveSeq,delaySeq])
         group.timingMode = .EaseInEaseOut
         let repeatAction = SKAction.repeatActionForever(group)
         glyph.runAction(repeatAction)
         delay += 0.01
      }
   }

   func snappyEaseOut (t:Float) -> Float {
      return (t == 1.0) ? t : 1.0 - pow(2.0, -10.0 * t)
   }
}
```

## Installation

SwiftyGlyphs is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SwiftyGlyphs"
```

##### Manual Installation (copy 4 files)

`SwiftyGlyphs.swift, ImageExtractor.swift, Glyph.swift, SpriteGlyphs.swift`

## Author & licence

Woodie Dovich,  woodiewebsafe@gmail.com

SwiftyGlyphs is available under the MIT license. See the LICENSE file for more info.