module Spree
  class CroppedImage < Asset
    module Configuration
      module ActiveStorage
        extend ActiveSupport::Concern

        included do
          validate :check_attachment_content_type

          has_one_attached :attachment

          def accepted_image_types
            %w(image/jpeg image/jpg image/png image/gif)
          end

          def check_attachment_content_type
            if not_valid?
              errors.add(:attachment, :not_allowed_content_type)
            end
          end

          def not_valid?
            attachment.attached? && !attachment.content_type.in?(accepted_image_types)
          end

          def is_valid?
            attachment.attached? && attachment.content_type.in?(accepted_image_types)
          end

        end
      end
    end
  end
end
