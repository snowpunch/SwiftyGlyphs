# SwiftyGlyphs

[![CI Status](http://img.shields.io/travis/Woodie Dovich/SwiftyGlyphs.svg?style=flat)](https://travis-ci.org/Woodie Dovich/SwiftyGlyphs)
[![Version](https://img.shields.io/cocoapods/v/SwiftyGlyphs.svg?style=flat)](http://cocoapods.org/pods/SwiftyGlyphs)
[![License](https://img.shields.io/cocoapods/l/SwiftyGlyphs.svg?style=flat)](http://cocoapods.org/pods/SwiftyGlyphs)
[![Platform](https://img.shields.io/cocoapods/p/SwiftyGlyphs.svg?style=flat)](http://cocoapods.org/pods/SwiftyGlyphs)

## Usage

Create and position a label of text. Then grab the array of Glyph to animate.

```swift
var swiftyLabel = SwiftyGlyphs(fontName: "MarkerFelt-Wide", size:24)
swiftyLabel.text = "SwiftyGlyphs!"
swiftyLabel.setLocation(self.view, pos: CGPoint(x:0,y:100))
swiftyLabel.centerTextToView()

// the glyphs for you to animate.
let glyphs:[Glyph] = swiftyLabel.getGlyphs()
```

If you want to use SpriteKit within a normal UIViewController just add UIView to your nib/storyboard and customize as 'SKView'. 

The following code shows how to create SKSpriteNode glyphs for all of your SKAction needs.

```swift
var spriteLabel = SpriteGlyphs(fontName: "Copperplate-Light", size:24)
spriteLabel.text = "SpriteKit Baby!!"
spriteLabel.setLocation(skview, pos: CGPoint(x:0,y:30))
spriteLabel.centerTextToView()

// the glyphs for you to animate.
let glyphs:[Glyph] = swiftyLabel.getGlyphs()
```

Here is a more detailed swift 2.2 example showing both normal SwiftyGlyphs, and also the optional SpiteGlyphs.

```swift
var swiftyLabel = SwiftyGlyphs(fontName: "MarkerFelt-Wide", size:24)

@IBOutlet weak var skview: SKView!
var spriteLabel = SpriteGlyphs(fontName: "Copperplate-Light", size:24)

override func viewDidAppear(animated: Bool) {
super.viewDidAppear(animated)

// SwiftyGlyphs example.
swiftyLabel.text = "SwiftyGlyphs!"
swiftyLabel.setLocation(self.view, pos: CGPoint(x:0,y:100))
swiftyLabel.centerTextToView()
// noSpriteKitNeededAnimation(swiftyLabel.getGlyphs())

// SpriteGlyphs example.
spriteLabel.text = "SpriteKit Baby!!"
spriteLabel.setLocation(skview, pos: CGPoint(x:0,y:30))
spriteLabel.centerTextToView()
// spriteKitAnimation(spriteLabel)
}
```

Example method animating normal SwiftyGlyphs:

```swift
func noSpriteKitNeededAnimation(glyphs:[Glyph]) {
    var delay = 1.0
    for glyph in glyphs {
        UIView.animateWithDuration(0.5, delay: delay, options: [.Repeat, .CurveEaseInOut, .Autoreverse], animations: {
            glyph.imgView.center.y = 140
            glyph.imgView.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI))
        }, completion: nil)
        delay += 0.01
    }
}
```

'Conceptual' example method animating an array of SKSpriteNode characters.
I didn't acually run this. It's only here to demonstrate what SKActions look like.

```swift
func spriteKitAnimation(glyphSprites:SpriteGlyphs) {
    let sprites = glyphSprites.getSprites()

    let moveSeq = SKAction.sequence([
        SKAction.moveBy(CGVector(dx:30,dy:0), duration: 0.3),
        SKAction.moveBy(CGVector(dx:0,dy:30), duration: 0.4),
        SKAction.moveBy(CGVector(dx:-30,dy:0), duration: 0.5),
        SKAction.moveBy(CGVector(dx:0,dy:-30), duration: 0.6),
    ])
    moveSeq.timingMode = .EaseIn

    let rotationSeq = SKAction.sequence([
        SKAction.rotateToAngle(CGFloat(M_PI), duration: 1),
        SKAction.rotateToAngle(0, duration: 2.0),
    ])

    let group = SKAction.group([moveSeq,rotationSeq]) // simultaneous
    let repeatAction = SKAction.repeatActionForever(group)

    for glyph in sprites {
        glyph.runAction(repeatAction)
    }
}
```

## Installation

SwiftyGlyphs is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SwiftyGlyphs"
```

#### Manually

Simply copy the 4 source files to your Xcode project.
`SwiftyGlyphs.swift, ImageExtractor.swift, Glyph.swift, SpriteGlyphs.swift`

## Author and licence

Woodie Dovich, woodiewebsafe@gmail.com

SwiftyGlyphs is available under the MIT license. See the LICENSE file for more info.
