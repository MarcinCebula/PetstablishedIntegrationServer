module PetfinderIntegration
  module Query
    module Shelter
      def self.get(id)
        params =  { 'id' => id }
        result = PetfinderIntegration::Connection.get('shelter.get', params)
        PetfinderIntegration::Models::Shelter.new(result['petfinder']['shelter']).run
      end
    end
    module PetThroughShelter
        # params = params.marge(options)
    end
  end
end
