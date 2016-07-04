Pod::Spec.new do |s|
  s.name             = "Szimpla"
  s.version          = "0.0.2"
  s.summary          = "Networking Testing library for Swift"
  s.description      = <<-DESC
 Networking testing library that records requests and match them later with future tests executions.
                       DESC
  s.homepage         = "https://github.com/pepibumur/Szimpla"
  s.license          = 'MIT'
  s.author           = { "Pedro Piñera Buendía" => "pepibumur@gmail.com" }
  s.source           = { :git => "https://github.com/pepibumur/Szimpla.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/pepibumur'
  s.ios.deployment_target = '8.0'

  # Dependencies
  s.dependency 'SwiftyJSON'
  s.dependency 'NSURL+QueryDictionary'
  s.frameworks = 'XCTest'

  # Files
  s.source_files = 'Szimpla/Classes/**/*'

end
