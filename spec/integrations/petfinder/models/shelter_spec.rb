require 'rails_helper'

describe PetfinderIntegration::Models::Shelter, :focus => true do
  subject { PetfinderIntegration::Models::Shelter }


  let(:shelter_ny803) {
    VCR.use_cassette 'shelter/NY803' do
      Curl::Easy.perform('http://api.petfinder.com/shelter.get?key=3ea4a92e053a83bda1d17959baf8b158&id=NY803&format=json')
    end
  }
  let(:shelter) { JSON.parse(shelter_ny803.body)['petfinder']['shelter'] }

  let(:object) { subject.new(shelter) }
  shelter_fields = [:country, :longitude, :latitude, :name, :phone, :state, :address1, :address2, :email, :city, :zip, :fax, :id]

  shelter_fields.each do |field|
    it "should respond to #{field}" do
      expect(object).to respond_to(field)
    end
  end
  describe 'run' do
    it 'should convert data into Shelter object' do
      expect { object.run }.not_to raise_error
    end

    shelter_fields.each do |field|
      it "should only pass if #{field} is not nil" do
        expect(object.send(field)).to eq nil
        object.run
        expect(object.send(field)).not_to eq nil
      end
    end
  end










  #------------------ Might want to extract this ------------------
  describe 'private' do
    it 'set_instance_variables should take a hash and converted it into instance variables' do
      data = {"country"=>["hasShots", "altered", "housetrained"] }
      expect(object.country).to eq nil
      object.send(:set_instance_variables, data)
      expect(object.country).to eq ["hasShots", "altered", "housetrained"]
    end

    context 'cleanup(data, exclude)' do
      it 'should exclude keys' do
        expect(object).to receive(:exclude_keys).with([], ['test1', 'test2']).and_return({})
        object.send(:cleanup, {}, ['test1', 'test2'])
      end
      it 'should convert empty hash to empty string if key not plural' do
        data = { "shelterPetId"=>{} }
        expect(object.send(:cleanup, data)).to eq({ "shelter_pet_id"=>"" })
      end
      it 'should convert empty hash to empty array if key plural' do
        data = { "options"=>{} }
        expect(object.send(:cleanup, data)).to eq({ 'options' => [] })
      end
      it 'should covert plural hash to clean hash.' do
        data = { "options"=>{"option"=>[{"$t"=>"hasShots"}, {"$t"=>"altered"}, {"$t"=>"housetrained"}]} }
        expect(object.send(:cleanup, data)).to eq({ 'options' => ['hasShots', 'altered', 'housetrained'] })
      end
      it 'should covert singular hash to clean hash.' do
        data = { "name"=>{"$t"=>"Kew"} }
        expect(object.send(:cleanup, data)).to eq({ 'name' => 'Kew' })
      end
      it 'should covert camelcase to snake case' do
        data = { "shelterId"=>{"$t"=>"NY803"} }
        expect(object.send(:cleanup, data)).to eq({ 'shelter_id' => 'NY803' })
      end
    end

    it "exclude_keys, should exclude ['mouse', 'rat', 'fish']" do
      expect(object.send(:exclude_keys, ['dog', 'mouse', 'cat', 'rat'], ['mouse', 'rat', 'fish'])).to eq(['dog', 'cat'])
    end

    context 'is_plural?' do
      it 'cat, should return false' do
        expect(object.send(:is_plural?, 'cat')).to eq false
      end
      it 'cats, should return true' do
        expect(object.send(:is_plural?, 'cats')).to eq true
      end
    end
    #------------------------ end --------------------------------


  end
end
