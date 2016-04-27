
Pod::Spec.new do |s|

  s.name         = "SwiftyGlyphs"
  s.version      = "0.1.3"
  s.summary      = "Animate individual characters in a label. SpriteKit optional."

# s.description  = <<-DESC
#                   A longer description of SwiftyGlyphs in Markdown format.
#
#                   * Think: Why did you write this? What is the focus? What does it do?
#                   * CocoaPods will be using this to generate tags, and improve search results.
#                   * Try to keep it short, snappy and to the point.
#                   * Finally, don't worry about the indent, CocoaPods strips it!
#                   DESC

  s.homepage     = "https://github.com/snowpunch/SwiftyGlyphs"



  s.license      = "MIT"

  s.author           = { "Woodie Dovich" => "woodiewebsafe@gmail.com" }

  s.platform     = :ios, "9.0"

  # s.ios.deployment_target = "5.0"

  s.source       = { :git => "https://github.com/snowpunch/SwiftyGlyphs.git", :tag => "0.1.3" }


  s.source_files  =  'Source/*'

  # s.public_header_files = "Classes/**/*.h"


end
