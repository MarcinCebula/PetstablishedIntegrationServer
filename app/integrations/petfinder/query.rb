module PetfinderIntegration
  module Query
    module Shelter
      def self.get(id)
        params =  { 'id' => id }
        result = PetfinderIntegration::Connection.get('shelter.get', params)
        PetfinderIntegration::Models::Shelter.new(result['petfinder']['shelter']).run
      end
    end
    module PetsThroughShelter
      def self.get(params)
        result = PetfinderIntegration::Connection.get('shelter.getPets', params)
        (result['petfinder']['pets']['pet'] || []).map do |pet|
          PetfinderIntegration::Models::Pet.new(pet).run
        end
      end

      def self.get_with_filter_inclusive(params, filters)
        result = self.get(params)
        filters.map do |filter|
          result.select { |pet| (pet.send(filter.keys[0].to_sym).downcase).include? filter.values[0].downcase }
        end.flatten.uniq
      end
    end
  end
end
