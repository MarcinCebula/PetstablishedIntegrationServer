require "rails_helper"

describe PetfinderIntegration::Models::Pet, :focus => false do
  subject { PetfinderIntegration::Models::Pet }

  let(:shelter_get_10_pets_from_NY803) {
    VCR.use_cassette 'shelter_getpets/10_from_NY803' do
      Curl::Easy.perform('http://api.petfinder.com/shelter.getPets?key=3ea4a92e053a83bda1d17959baf8b158&id=NY803&format=json&output=full&count=10')
    end
  }
  let(:pets) { JSON.parse(shelter_get_10_pets_from_NY803.body)['petfinder']['pets']['pet'] }
  let(:pet) { pets[7] }
  let(:pet_object) { subject.new(pet) }
  pet_fields = [:options, :breeds, :shelter_pet_id, :status, :name, :contact, :description,
                :sex, :age, :size, :mix, :shelter_id, :last_update, :media, :id, :animal, :images]

  pet_fields.each do |field|
    it 'should respond to #{field}' do
      expect(pet_object).to respond_to(field)
    end
  end
  describe 'create' do
    it 'should convert data into Pet object' do
      expect(pet_object).not_to raise_error
    end

    pet_fields.each do |field|
      it 'should only pass if #{field} is not nil' do
        expect(pet_object.send(field).run).not_to eq nil
      end
    end
  end
  describe 'private' do
    context 'cleanup(data, exclude)' do
      it 'should exclude keys' do
        expect(pet_object).to receive(:exclude_keys).with({}, ['test1', 'test2'])
        pet_object.send(:cleanup, {}, ['test1', 'test2'])
      end
      it 'should convert empty hash to empty string if key not plural' do
        data = { "shelterPetId"=>{} }
        expect(pet_object.send(:cleanup, data)).to eq({ "shelter_pet_id"=>"" })
      end
      it 'should convert empty hash to empty array if key plural' do
        data = { "options"=>{} }
        expect(pet_object.send(:cleanup, data)).to eq({ 'options' => [] })
      end
      it 'should covert plural hash to clean hash.' do
        data = { "options"=>{"option"=>[{"$t"=>"hasShots"}, {"$t"=>"altered"}, {"$t"=>"housetrained"}]} }
        expect(pet_object.send(:cleanup, data)).to eq({ 'options' => ['hasShots', 'altered', 'housetrained'] })
      end
      it 'should covert singular hash to clean hash.' do
        data = { "name"=>{"$t"=>"Kew"} }
        expect(pet_object.send(:cleanup, data)).to eq({ 'name' => 'Kew' })
      end
      it 'should covert camelcase to snake case' do
        data = { "shelterId"=>{"$t"=>"NY803"} }
        expect(pet_object.send(:cleanup, data)).to eq({ 'shelter_id' => 'NY803' })
      end
    end
    context 'clean_images', :focus => true do
      it 'should convert media["photos"] data  into array of hashes of images' do
        data = pets[2]['media']
        result = pet_object.send(:cleanup_images, data)
        expect(result.length).to eq 3
        expect(result[0]['thumbnail']['url']).to eq 'http://photos.petfinder.com/photos/pets/20115107/1/?bust=1309835669&width=50&-t.jpg'
        expect(result[0]['thumbnail']['size']).to eq 't'
        expect(result[0]['thumbnail']['id']).to eq 1
      end

      it 'should convert media["photos"] to [] if photos are empty' do
        data = { "photos"=> {"photo"=> {} } }
        result = pet_object.send(:cleanup_images, data)
        expect(result.length).to eq 0
        expect(result).to eq []
      end
    end
    context 'apply_translations_for_status' do
      let(:status_adoptable) { {'status' => 'A' } }
      let(:status_unknown) { { 'status' => '' } }
      it 'should add verbose translation for A status' do
        expect(pet_object.send(:apply_translation_for_status, status_adoptable)).to eq({'value' => 'A', 'verbose' => 'adoptable' })
      end
      it 'should add verbose translation unknown status' do
        expect(pet_object.send(:apply_translation_for_status, status_unknown)).to eq({ 'value' => '', 'verbose' => 'unknown' })
      end
    end
    it 'convert_to_instance_variables should take a hash and converted it into instance variables' do

    end
    it "exclude_keys, should exclude ['mouse', 'rat', 'fish']" do
      expect(pet_object.send(:exclude_keys, ['dog', 'mouse', 'cat', 'rat'], ['mouse', 'rat', 'fish'])).to eq(['dog', 'cat'])
    end
    context 'is_plural?' do
      it 'cat, should return false' do
        expect(pet_object.send(:is_plural?, 'cat')).to eq false
      end
      it 'cats, should return true' do
        expect(pet_object.send(:is_plural?, 'cats')).to eq true
      end
    end
  end
end
