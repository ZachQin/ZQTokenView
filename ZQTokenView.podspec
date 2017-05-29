Pod::Spec.new do |s|
  s.name         = "ZQTokenView"
  s.version      = "0.0.1"
  s.summary      = "An iOS Token view based on UICollectionView."
  s.description  = <<-DESC
                    An iOS view based on UICollectionView. It implements dragging to order and delete.
                   DESC
  s.homepage     = "https://github.com/ZachQin/ZQTokenView"
  s.license      = "MIT"
  s.author             = { "Zach Qin" => "qzkmas@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/ZachQin/ZQTokenView.git", :tag => "#{s.version}" }
  s.source_files  = "ZQTokenView/*.{h,m}"
  s.public_header_files = "ZQTokenView/*.{h}"
  s.resources = "ZQTokenView/Explode/*.png"
  s.frameworks   = "CoreGraphics", "QuartzCore"
  s.requires_arc = true
end
