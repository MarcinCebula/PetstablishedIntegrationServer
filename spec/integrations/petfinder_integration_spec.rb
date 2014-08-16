require 'rails_helper'
describe PetfinderIntegration, :focus => true do
  subject { PetfinderIntegration }

  it 'should have api url' do
    expect(PetfinderIntegration.endpoint).to eq 'http://api.petfinder.com'
  end
end
