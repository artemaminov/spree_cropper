FactoryBot.define do
  factory :cropped_image, class: Spree::CroppedImage do
    if Rails.application.config.use_paperclip
      attachment { File.new(Spree::Core::Engine.root + 'spec/fixtures' + 'thinking-cat.jpg') }
    else
      dimensions { [{ "name": "desktop", "width": 1800, "height": 703, "y": 399,"x": 225}] }
      before(:create) do |cropped_image|
        cropped_image.attachment.attach(io: File.new(Spree::Core::Engine.root + 'spec/fixtures' + 'thinking-cat.jpg'), filename: 'thinking-cat.jpg')
      end
    end
  end
end
