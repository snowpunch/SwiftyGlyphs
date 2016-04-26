Pod::Spec.new do |s|
  s.name             = "SwiftyGlyphs"
  s.version          = "0.1.0"
  s.summary          = "Animate individual characters in a label. SpriteKit optional."
  s.homepage         = "https://github.com/snowpunch/SwiftyGlyphs"
  s.license          = 'MIT'
  s.author           = { "Woodie Dovich" => "woodiewebsafe@gmail.com" }
  s.source           = { :git => "https://github.com/snowpunch/SwiftyGlyphs.git", :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'SwiftyGlyphs/*.swift'
end