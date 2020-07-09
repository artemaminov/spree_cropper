module Spree
  class CropperSetting < Preferences::Configuration
    preference :enabled, :boolean, default: true
    preference :devices, :hash, default: {
        desktop: {
            width: 1440,
            height: 400
        },
        tablet_landscape: {
            width: 1024,
            height: 300
        },
        tablet_portrait: {
            width: 600,
            height: 200
        },
        mobile: {
            width: 200,
            height: 300
        }
    }
  end
end
