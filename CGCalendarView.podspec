Pod::Spec.new do |s|
  s.name         = "CGCalendarView"
  s.version      = "0.0.1"
  s.summary      = "A Lightweight Horizontal Calendar/Date Picker inspired by Square's TimesSquare"
  s.homepage     = "https://github.com/CapitalGene/objc-CGCalendarView"
  s.license      = "MIT"
  s.authors      = { "Chen Liang" => "code@chen.technology" }
  s.source       = { :git => "https://github.com/CapitalGene/objc-CGCalendarView.git", :tag => '0.0.1'}
  s.frameworks   = 'Foundation', 'CoreGraphics', 'UIKit'
  s.platform     = :ios, '6.0'
  s.source_files = 'src/*.{h,m}'
  s.screenshot   = "https://github.com/CapitalGene/objc-CGCalendarView/raw/master/doc/img/capitalgene_sc_calendar.png"
  s.requires_arc = true
end
