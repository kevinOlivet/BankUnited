Pod::Spec.new do |s|
  s.name             = 'BankUnited'
  s.version          = '0.1.0'
  s.summary          = 'BankUnited Module'

  s.description      = <<-DESC
A module for BankUnited.  Can inject into BasicMainApp
                       DESC

  s.homepage         = 'https://github.com/Kevin Olivet/BankUnited'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Kevin Olivet' => 'japanart1234@yahoo.com' }
  s.source           = { :git => 'https://github.com/Kevin Olivet/BankUnited.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.swift_version = '5.0'

  s.source_files = 'BankUnited/Classes/**/*'
  s.resources = [
  'BankUnited/Assets/**/*.{storyboard,xib,xcassets,html,json,pdf,otf,ttf,plist,strings}'
  ]

  s.dependency 'BasicCommons'
  s.dependency 'BasicUIElements'

end
