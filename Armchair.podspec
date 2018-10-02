Pod::Spec.new do |s|

  s.name                  = "Armchair"
  s.version               = "0.3.5"
  s.summary               = "A simple yet powerful App Review Manager for iOS and OSX in Swift"
  s.description           = <<-DESC
                            A simple yet powerful App Review Manager for iOS and OSX in Swift.
                            * 100% Swift
                            * Both iOS and OS X Support
                            * Fully Configurable at Runtime
                            * Default Localizations for Dozens of Languages
                            * Prevent Rating Prompts on Different Devices
                            * Uses UIApplication/NSApplication Lifecycle Notifications
                            * Easy to Setup
                            * iTunes Affiliate Codes
                            * Ready For Primetime
                            DESC
  s.homepage              = "https://github.com/UrbanApps/Armchair"
  s.screenshots           = "https://raw.githubusercontent.com/UrbanApps/Armchair/assets/armchair-iOS.png", "https://raw.githubusercontent.com/UrbanApps/Armchair/assets/armchair-OSX.png"
  s.social_media_url      = 'https://twitter.com/coneybeare'
  s.authors               = { 'Matt Coneybeare' => 'coneybeare@urbanapps.com' }
  s.source                = { :git => 'https://github.com/UrbanApps/Armchair.git', :tag => s.version }

  s.license               = { :type => "MIT", :file => "LICENSE" }
  
  s.source_files          = "Source/*.{h,swift}"
  s.resources             = "Localization/*.lproj"
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.requires_arc          = true
  s.swift_version         = '4.2'

end
