Pod::Spec.new do |s|
  s.name     = 'CanvasKit'
  s.version  = '0.42'
  s.license  = 'MIT'
  s.summary  = 'A Canvas API integration framework better than bamboo'
  s.homepage = 'https://github.com/instructure/CanvasKit'
  s.authors  = { 'Rick Roberts' => 'elgreco84@gmail.com', 'Jason Larsen' => 'jason.larsen@gmail.com' }
  s.source   = { :git => 'https://github.com/instructure/CanvasKit.git', :tag => 'v0.42' }
  s.source_files = 'CanvasKit/**/*.{h,m}'
  s.requires_arc = true

  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.9'

  s.dependency 'AFNetworking', '2.0'
  s.dependency 'Mantle'
  s.dependency 'ISO8601DateFormatter'
end
