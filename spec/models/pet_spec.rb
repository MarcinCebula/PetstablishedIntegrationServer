require "rails_helper"

describe Pet, :focus => true do
  subject { Pet }

  let(:shelter_NY803_hash) {
    {"country"=>"US",
      "longitude"=>"-73.9538",
      "latitude"=>"40.7118",
      "name"=>"Empty Cages Collective",
      "phone"=>"1 (800) 880-2684",
      "state"=>"NY",
      "address1"=>"302 Bedford Avenue, PMB: 301",
      "address2"=>"",
      "email"=>"adopt@emptycagescollective.org",
      "city"=>"Brooklyn",
      "zip"=>"11211",
      "fax"=>"",
      "id"=>"NY803"}
  }

  let(:pet_24747073) {
    {"options"=>["hasShots", "altered", "housetrained"],
      "breeds"=>["Domestic Short Hair"],
      "shelter_pet_id"=>"",
      "status"=>{"value"=>"A", "verbose"=>"adoptable"},
      "name"=>"Kew",
      "contact"=>{"email"=>"adopt@emptycagescollective.org", "zip"=>"11211", "city"=>"Brooklyn", "fax"=>"", "address1"=>"302 Bedford Avenue, PMB: 301", "phone"=>"1 (800) 880-2684", "state"=>"NY", "address2"=>""},
      "description"=>
      "\nKew is one of the 23 cats Empty Cages Collective recently rescued from \"living\" in a car in Queens. Kew was almost dumped in a park the day before the hurricane until ECC stepped in to help. He's a handsome boy of about three years, and he is looking for a home to call his own.\n\n",
      "sex"=>"M",
      "age"=>"Adult",
      "size"=>"M",
      "mix"=>"no",
      "shelter_id"=>"NY803",
      "last_update"=>"2012-11-28T01:03:25Z",
      "media"=>
      {"images"=>
        [{"tiny"=>{"url"=>"http://photos.petfinder.com/photos/pets/24747073/1/?bust=1354064481&width=60&-pnt.jpg", "size"=>"pnt", "id"=>1},
           "small"=>{"url"=>"http://photos.petfinder.com/photos/pets/24747073/1/?bust=1354064481&width=95&-fpm.jpg", "size"=>"fpm", "id"=>1},
           "large"=>{"url"=>"http://photos.petfinder.com/photos/pets/24747073/1/?bust=1354064481&width=500&-x.jpg", "size"=>"x", "id"=>1},
           "medium"=>{"url"=>"http://photos.petfinder.com/photos/pets/24747073/1/?bust=1354064481&width=300&-pn.jpg", "size"=>"pn", "id"=>1},
           "thumbnail"=>{"url"=>"http://photos.petfinder.com/photos/pets/24747073/1/?bust=1354064481&width=50&-t.jpg", "size"=>"t", "id"=>1}}]},
      "id"=>"24747073",
      "animal"=>"Cat"}
  }

  describe 'create' do
    before(:each) do
      Shelter.create!(shelter_NY803_hash)
    end
    it 'should create Shelter record and not throw exception' do
      shelter = Shelter.first
      expect { shelter.pets.create!(pet_24747073) }.not_to raise_error
      expect(shelter.pets.count).to eq 1
    end
    context 'should fail' do
      before(:each) do
        shelter = Shelter.first
        shelter.pets.create!(pet_24747073)
      end
      it 'has duplicate data and it should raise exception' do
        shelter = Shelter.first
        expect { shelter.pets.create!(pet_24747073) }.to raise_error
      end
    end

    # ------------------------- Extract to Shared Example -------------------------------
    describe 'before_filter method' do
      it 'create_uid should set NY803 is uid ' do
        expect(subject.new.send(:create_uid, "NY803")).to eq "ny803"
      end
      it 'create_url_id should convert "Empty Cages Collective" to url type format and set as url_id ' do
        expect(subject.new.send(:create_url_id, "Empty Cages Collective")).to eq "empty-cages-collective"
      end
    end
    # ---------------------------------------- end ---------------------------------------

  end
end
