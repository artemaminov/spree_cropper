FactoryBot.define do
  factory :cropper, class: 'Spree::Cropper' do
    width { FFaker::Random.rand 2000 }
    height { FFaker::Random.rand 2000 }
    x { FFaker::Random.rand 2000 }
    y { FFaker::Random.rand 2000 }
    cmd { "#{width}x#{height}+#{x}+#{y}" }
  end
end