require 'carrierwave/test/matchers'
require 'rails_helper'
include AuthenticationHelper

describe AvatarUploader do
  include CarrierWave::Test::Matchers

  let(:adam) { FactoryBot.create(:user) }
  before(:each) do
    sign_in(adam)
  end


  let(:uploader) { AvatarUploader.new(adam, :avatar) }

  before do
    AvatarUploader.enable_processing = true
    File.open("/Users/adam/challenges/crypto_tracker/public/uploads/tmp/20171025_121206.jpg") { |f| uploader.store!(f) }
  end

  after do
    AvatarUploader.enable_processing = false
    uploader.remove!
  end

  context 'the thumb version' do
    it "scales down a landscape image to be exactly 50 by 45 pixels" do
      expect(uploader.thumb).to have_dimensions(50, 45)
    end
  end

  context 'the small version' do
    it "scales down a landscape image to fit within 200 by 200 pixels" do
      expect(uploader).to be_no_larger_than(200, 200)
    end
  end

  it "makes the image readable only to the owner and not executable" do
    expect(uploader).to have_permissions(0644)
  end

  it "has the correct format" do
    expect(uploader).to be_format('JPEG')
  end
end
