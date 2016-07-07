Pod::Spec.new do |s|
  s.name             = "Szimpla"
  s.version          = "0.0.3"
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

  s.subspec 'Core' do |sp|
    sp.source_files = 'Szimpla/Classes/Core/**/*'
  end

  s.subspec 'Server' do |sp|
    sp.source_files = 'Szimpla/Classes/Server/**/*'
    sp.dependency 'NSURL+QueryDictionary'
    sp.dependency 'SwiftyJSON'
    sp.dependency 'Swifter'
    sp.dependency 'Szimpla/Core'
  end

  s.subspec 'Client' do |sp|
    sp.source_files = 'Szimpla/Classes/Client/**/*'
    sp.framework = 'XCTest'
    sp.dependency 'SwiftyJSON'
    sp.dependency 'Szimpla/Core'
  end

end
