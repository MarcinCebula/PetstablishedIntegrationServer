require 'rails_helper'

describe PetfinderManager, :vcr_off => true  do
  subject { PetfinderManager }

  describe 'store_only_cats_and_dogs_for_organization' do
    it 'shuld fetch 2 pets for organization id "NY803"' do
      expect { subject.store_only_cats_and_dogs_for_organization('NY803', 2) }.not_to raise_error
      expect(Shelter.count).to eq 1
      expect(Shelter.first.name).to eq 'Empty Cages Collective'

      # This test only passes if the api resposne doesn't change.
      # Currently it returns 2 cats. Not a good test.
      expect(Shelter.first.pets.count).to eq 2
    end

    context 'Update data' do
      before(:each) do
        subject.store_only_cats_and_dogs_for_organization('NY803', 2)
      end
      it 'should update data and not raise an exception' do
        expect { subject.store_only_cats_and_dogs_for_organization('NY803', 2) }.not_to raise_error
        expect(Shelter.count).to eq 1
        expect(Shelter.first.name).to eq 'Empty Cages Collective'

        # This test only passes if the api resposne doesn't change.
        # Currently it returns 2 cats. Not a good test.
        expect(Shelter.first.pets.count).to eq 2
      end
    end
  end

end
