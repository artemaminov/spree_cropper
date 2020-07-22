FactoryBot.define do
  factory :device, class: 'Spree::Cropper::Device' do
    name { FFaker::AnimalUS.common_name }
    width { FFaker::Random.rand(1000) }
    height { FFaker::Random.rand(1000) }
  end
end