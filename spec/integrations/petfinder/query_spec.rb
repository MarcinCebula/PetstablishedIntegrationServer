require "rails_helper"

describe PetfinderIntegration::Query::Shelter, :focus => true do
  subject { PetfinderIntegration::Query::Shelter }

  let(:shelter_ny803) {
    VCR.use_cassette 'shelter/NY803' do
      Curl::Easy.perform('http://api.petfinder.com/shelter.get?key=3ea4a92e053a83bda1d17959baf8b158&id=NY803&format=json')
    end
  }
  let(:shelter_ny803_response) { JSON.parse(shelter_ny803.body) }
  describe '.get' do
    it 'should retrive shelter information by shelter id NY803' do
      expect(PetfinderIntegration::Connection).to receive(:get).with("shelter.get", {"id"=>"NY803"}).and_return(shelter_ny803_response)
      result = PetfinderIntegration::Query::Shelter.get('NY803')
      expect(result).to be_instance_of PetfinderIntegration::Models::Shelter
      expect(result.id).to eq 'NY803'
      expect(result.name).to eq 'Empty Cages Collective'
    end
  end
end

describe PetfinderIntegration::Query::PetThroughShelter, :focus => true do
  subject { PetfinderIntegration::Query::PetThroughShelter }
end
