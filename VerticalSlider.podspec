Pod::Spec.new do |s|

  s.name         = "VerticalPicker"
  s.version      = "0.1.1"
  s.summary      = "Vertical slider control."
  s.description  = <<-DESC
VerticalPicker is control like slider in iOS11 Control Center.
                   DESC

  s.homepage     = "https://github.com/escfrya/VerticalPicker"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "Igor Skovorodkin" => "escfrya@mail.ru" }
  s.platform     = :ios
  s.ios.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/escfrya/VerticalPicker.git", :tag => "#{s.version}" }
  s.source_files  = "VerticalPicker/**/*.{swift}"
  s.framework  = "UIKit"
end
