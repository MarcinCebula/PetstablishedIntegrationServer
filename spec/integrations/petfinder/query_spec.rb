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

describe PetfinderIntegration::Query::PetsThroughShelter, :focus => true do
  subject { PetfinderIntegration::Query::PetsThroughShelter }

  let(:shelter_get_10_pets_from_NY803) {
    VCR.use_cassette 'shelter_getpets/10_from_NY803' do
      Curl::Easy.perform('http://api.petfinder.com/shelter.getPets?key=3ea4a92e053a83bda1d17959baf8b158&id=NY803&format=json&output=full&count=10')
    end
  }
  let(:shelter_get_10_pets_from_NY803_json) { JSON.parse(shelter_get_10_pets_from_NY803.body) }

  describe '.get' do
    it 'should retrive pets information by shelter id NY803' do
      params = { 'output' => 'full', 'count' => '10', 'id' => 'NY803' }
      expect(PetfinderIntegration::Connection).to receive(:get).with("shelter.getPets", params).and_return(shelter_get_10_pets_from_NY803_json)

      result = PetfinderIntegration::Query::PetsThroughShelter.get(params)
      expect(result.first).to be_instance_of PetfinderIntegration::Models::Pet
      expect(result.count).to eq 10
    end
  end
  describe '.get_with_filter_inclusive' do
    it 'should retrive pets by shelter id NY803 and filter only dogs and cats' do
      params = { 'output' => 'full', 'count' => '10', 'id' => 'NY803' }
      filters = [{ 'animal' => 'cat' }, { 'animal' => 'dog' }]
      expect(PetfinderIntegration::Connection).to receive(:get).with("shelter.getPets", params).and_return(shelter_get_10_pets_from_NY803_json)
      result = PetfinderIntegration::Query::PetsThroughShelter.get_with_filter_inclusive(params, filters)
      expect(result.count).to eq 7
      animals = result.map { |pet| pet.animal }
      expect(animals - ["Cat", "Dog"]).to eq []
    end
  end
end
