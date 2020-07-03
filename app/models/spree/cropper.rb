module Spree
  class Cropper < Spree::Base
    has_many :images, class_name: 'Spree::CropperImage', dependent: :destroy

    validates_presence_of :width, :height, :x, :y, :cmd

  end
end