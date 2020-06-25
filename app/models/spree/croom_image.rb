module Spree
  class CroomImage < Spree::Base
    belongs_to :spree_croom_device, :class_name => 'Spree::CroomDevice'
    belongs_to :spree_asset
  end
end
