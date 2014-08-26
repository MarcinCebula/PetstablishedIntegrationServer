require "rails_helper"

describe "API::Registration" do

  it "Register user and return user Authentication Token", :focus => true do
    post "/api/registration/register", :user => {
      :email => "Marcin.K.Cebula@gmail.com",
      :password => "password123",
      :password_confirmation => "password123"
    }
    resp = JSON.parse(response.body)

    # expect(resp).to eq
  end
  context "User Registration Fails", :focus => false do
    it "requires email, password and password_confirmation" do
      post "/api/registration/register", :user => {
        :email => "",
        :password => "",
        :password_confirmation => ""
      }
      resp = JSON.parse(response.body)

      # expect(resp).to eq
    end
  end
end
