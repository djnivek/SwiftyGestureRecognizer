Pod::Spec.new do |s|
  s.name         = "SwiftyGestureRecognizer"
  s.version      = "0.1"
  s.summary      = ""
  s.description  = <<-DESC
    Your description here.
  DESC
  s.homepage     = "https://github.com/djnivek/SwiftyGestureRecognizer"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Kevin MACHADO" => "machadokevin.dev@gmail.com" }
  s.social_media_url   = ""
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/djnivek/SwiftyGestureRecognizer.git", :tag => s.version.to_s }
  s.source_files  = "Sources/**/*"
  s.frameworks  = "Foundation"
end