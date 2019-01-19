Pod::Spec.new do |s|
  s.name         = "SwiftyGlyphs"
  s.version      = "2.0.0"
  s.summary      = "Animate individual characters in a label. SpriteKit optional."
  s.homepage     = "https://github.com/snowpunch/SwiftyGlyphs"
  s.license      = "MIT"
  s.author       = { "Woodie Dovich" => "woodiewebsafe@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/snowpunch/SwiftyGlyphs.git", :tag => s.version }
  s.source_files = "Sources/*.swift"
  s.swift_version = '4.2'
end
