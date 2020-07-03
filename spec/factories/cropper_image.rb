FactoryBot.define do
  factory :cropper_image, class: Spree::CropperImage do
    if Rails.application.config.use_paperclip
      attachment { File.new(Spree::Core::Engine.root + 'spec/fixtures' + 'thinking-cat.jpg') }
    else
      before(:create) do |cropper_image|
        cropper_image.attachment.attach(io: File.new(Spree::Core::Engine.root + 'spec/fixtures' + 'thinking-cat.jpg'), filename: 'thinking-cat.jpg')
      end
    end
  end
end
