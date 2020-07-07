require 'spec_helper'

RSpec.describe Spree::Cropper, type: :model do
  subject { build :cropper }
  let(:image) { create :cropped_image }

  context 'Validation' do
    it 'ok with valid attributes' do
      expect(subject).to be_valid
    end
    it 'fails without image' do
      subject.cropped_image = nil
      expect(subject).to_not be_valid
    end
  end

  context 'Associations' do
    it { should belong_to(:cropped_image) }
  end

  context 'Attributes' do
    it 'width to be valid' do
      expect(subject.width).to be_between(0, 2000).inclusive
    end
    it 'height to be valid' do
      expect(subject.height).to be_between(0, 2000).inclusive
    end
    it 'x to be valid' do
      expect(subject.x).to be_between(0, 2000).inclusive
    end
    it 'y to be valid' do
      expect(subject.y).to be_between(0, 2000).inclusive
    end
    it 'cmd to be valid' do
      expect(subject.cmd).to eq("#{subject.width}x#{subject.height}+#{subject.x}+#{subject.y}")
    end
  end

  context 'Image' do
    it 'can be attached' do
      expect(subject.cropped_image.attachment.filename).to eq('thinking-cat.jpg')
    end
    it 'can be cropped' do
      # byebug
      expect(subject.cropped_image.attachment.variant(crop: subject.cmd).blob.filename).to eq('thinking-cat.jpg')
    end
  end

  context 'Preferences' do
    it 'is enabled by default' do
      expect(SpreeCropper::Config.enabled).to be_truthy
    end
    it 'has preferences' do
      expect(SpreeCropper::Config.devices).to be_truthy
    end
  end

end
