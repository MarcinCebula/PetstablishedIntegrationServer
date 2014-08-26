require "rails_helper"

describe User, :focus => true do
  subject { User }

  describe "Create new User" do
    it "should not throw excpetion and increment User and set defaults" do
      expect(User.count).to eq 0
      expect { FactoryGirl.create(:user) }.not_to raise_error
      expect(User.count).to eq 1
      user = User.first
      user.active = false
    end
    it 'should throw expection if user already exists' do
      expect(User.count).to eq 0
      FactoryGirl.create(:user)
      user = FactoryGirl.attributes_for(:user)
      user[:email] = User.first.email
      expect { User.create!(user) }.to raise_error(Mongoid::Errors::Validations)
    end
    it 'should send out activation email if new user is created'
    it 'should not send out activation email if user fails to create'
  end
end
