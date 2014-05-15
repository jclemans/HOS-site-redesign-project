require 'spec_helper'

describe User do
  it 'should allow users to have assigned roles' do
    test_user = FactoryGirl.create(:user)
    test_user.add_role :DJ
    User.with_role(:DJ).should eq [test_user]
  end

  it { should respond_to :name}
  it { should respond_to :phone }
  it { should respond_to :djname }
end
