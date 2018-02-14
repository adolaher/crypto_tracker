require 'rails_helper'

RSpec.describe Coin, type: :model do
  it { should belong_to :user }
  it { should have_many :comments }

  it { should allow_value("Adam").for(:name) }
  it { should_not allow_value("").for(:name) }

  it { should allow_value("this.img").for(:picture) }
  it { should_not allow_value("").for(:picture) }
end
