require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should belong_to :coin }

  it { should allow_value("Test_comment").for(:title) }
  it { should_not allow_value("").for(:title) }

  it { should allow_value(5).for(:rating) }
  it { should_not allow_value(nil).for(:rating) }

  it { should allow_value("cool coin").for(:body) }

end
