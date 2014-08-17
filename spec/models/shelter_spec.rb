require "rails_helper"

describe Shelter, :focus => true do
  subject { Shelter }

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

  describe 'create' do
    it 'should create Shelter record and not throw exception' do
      expect { subject.create!(shelter_NY803_hash) }.not_to raise_error
      expect(subject.count).to eq 1
    end
    context 'should fail' do
      before(:each) do
        subject.create!(shelter_NY803_hash)
      end
      it 'has duplicate data and it should raise exception' do
        expect { subject.create!(shelter_NY803_hash) }.to raise_error
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
