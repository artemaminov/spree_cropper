FactoryBot.define do
  factory :dimension, class: 'Spree::CropperDimension' do
    name { FFaker::AnimalUS.common_name }
    width { FFaker::Random.rand(1000) }
    height { FFaker::Random.rand(1000) }
  end
end