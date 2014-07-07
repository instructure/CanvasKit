Pod::Spec.new do |s|
  s.name     = 'CanvasKit'
  s.version  = '0.52'
  s.license  = 'MIT'
  s.summary  = 'A Canvas API integration framework better than bamboo'
  s.homepage = 'https://github.com/instructure/CanvasKit'
  s.authors  = { 'Rick Roberts' => 'elgreco84@gmail.com', 'Jason Larsen' => 'jason.larsen@gmail.com' }
  s.source   = { :git => 'https://github.com/instructure/CanvasKit.git', :tag => 'v0.52' }
  s.requires_arc = true

  s.ios.deployment_target = '7.0'
  s.ios.source_files = 'CanvasKit/**/*.{h,m}'

  s.osx.deployment_target = '10.9'
  s.osx.source_files = 'CanvasKit/Helpers/*.{h,m}', 'CanvasKit/Models/*.{h,m}', 'CanvasKit/Networking/*.{h,m}', 'CanvasKit/CanvasKit.h', 'CanvasKit/Constants.h'

  s.dependency 'AFNetworking', '~> 2.0'
  s.dependency 'Mantle', '~> 1.0'
  s.dependency 'ISO8601DateFormatter'
  s.dependency 'ReactiveCocoa'
end
