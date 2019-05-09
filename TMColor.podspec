#
#  Be sure to run `pod spec lint TMColor.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "TMColor"
  spec.version      = "0.0.1"
  spec.summary      = "A short description of TMColor."

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  spec.description  = <<-DESC
                   DESC

  spec.homepage     = "http://github.com/inrtgdje/TMColor"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See https://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #


 spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "tianming tang" => "inrtgdje@gmail.com" }
  spec.authors            = { "tianming tang" => "inrtgdje@gmail.com" }
  spec.social_media_url   = "https://twitter.com/tianming tang"


  spec.ios.deployment_target = "9.0"
  spec.source  = { :git => "http://github.com/inrtgdje/TMColor.git", :tag => spec.version }

  spec.source_files = "TMColor/source/*.swift"

end
