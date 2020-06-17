Pod::Spec.new do |s|
  s.name        = "Transfiguration"
  s.version     = "2.0.0"
  s.summary     = "Mystical way to transform data into reusable view in Swift"
  s.homepage    = "https://github.com/siam-biswas/Transfiguration"
  s.license     = { :type => "MIT" }
  s.authors     = { "Siam Biswas" => "siam.biswas@icloud.com" }

  s.requires_arc = true
  s.swift_version = "4.2"
  s.ios.deployment_target = "8.0"
  s.source   = { :git => "https://github.com/siam-biswas/Transfiguration.git", :tag => s.version }
  s.source_files = "Sources/Transfiguration/**/*.swift"
end
