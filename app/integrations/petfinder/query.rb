module PetfinderIntegration
  module Query
    module Shelter
      def self.get(id)
        PetfinderIntegration::Connection.get('shelter.get', {'id' => id})
      end
    end
    module PetThroughShelter

    end
  end
end
