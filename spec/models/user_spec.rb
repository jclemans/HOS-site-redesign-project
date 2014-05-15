require 'spec_helper'

describe User do
  it 'should allow users to have assigned roles' do
    test_user = FactoryGirl.create(:user)
    test_user.add_role :DJ
    User.with_role(:DJ).should eq [test_user]
  end


  it { should validate_presence_of :name }

  it { should validate_presence_of :phone }
  it { should validate_uniqueness_of :phone } 

  it { should validate_presence_of :djname }
  it { should validate_uniqueness_of :djname } 


end
