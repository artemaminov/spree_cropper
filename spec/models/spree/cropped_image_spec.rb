require 'spec_helper'

RSpec.describe Spree::CroppedImage, type: :model do
  subject { create :cropped_image }
  # let(:cropper_device) { create :cropper_device }
  context 'Attributes' do
    it 'to be valid' do
      # byebug
      # subject.cropper_device = cropper_device
      # expect(subject.width).to eq 'sdfdf'
    end

    it 'device to be valid' do
      expect(subject.dimensions[0].name).to eq(SpreeCropper::Config.devices[:name])
    end
  end

  context 'Variants' do
    it 'create from "dimensions" json' do
      byebug
      json_cropper_attributes = subject.dimensions[0].to_json
      cropper = subject.croppers.build(cropped_image: subject)
      expect(cropper.from_json(json_cropper_attributes).save).to be_truthy
    end
  end

end
