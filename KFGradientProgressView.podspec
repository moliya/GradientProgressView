Pod::Spec.new do |s|

  s.name          = "KFGradientProgressView"
  s.version       = "1.3.0"
  s.summary       = "一个简单的进度条控件"
  s.homepage      = "https://github.com/moliya/GradientProgressView"
  s.license       = "MIT"
  s.author        = {'Carefree' => '946715806@qq.com'}
  s.source        = { :git => "https://github.com/moliya/GradientProgressView.git", :tag => s.version}
  s.source_files  = "Sources/*"
  s.requires_arc  = true
  s.platform      = :ios, '8.0'
  s.swift_version = '5.0'

end
