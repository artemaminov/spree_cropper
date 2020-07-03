module Spree
  class CropperSetting < Preferences::Configuration
    preference :enabled, :boolean, default: true
    preference :devices, :hash, default: {
        desktop: '1440x400>',
        tablet_landscape: '1024x300>',
        tablet_portrait: '600x200>',
        mobile: '200x200>'
    }
  end
end
