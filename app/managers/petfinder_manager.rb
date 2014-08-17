class PetfinderManager
  class << self

    # This would really be a good place to catch exceptions
    # Shelter and Pet IntegrationModels should extends StandardError
    # and rethrow exception if something goes wrong with fetching of
    # data.
    #
    # These Methods should return Messages to users. For storage
    # exceptions as well as api integration exceptions

    def store_only_cats_and_dogs_for_organization(organization_id, number_to_fetch)
      filters = [{ 'animal' => 'cat' }, { 'animal' => 'dog' }]
      params = { 'id' => organization_id, 'count' => number_to_fetch }
      shelter = Shelter.where(:id => organization_id).first
      unless shelter #exists?
        shelter_object_query = PetfinderIntegration::Query::Shelter.get(organization_id)
        shelter = create_or_update(shelter_object_query.to_model)
      end
      pets_object_query = PetfinderIntegration::Query::PetsThroughShelter.get_with_filter_inclusive({ 'id' => shelter.id,
                                                                                                      'count' => number_to_fetch}, filters)
      add_pets(shelter, pets_object_query.map(&:to_model))
    end
    def create_or_update(data)
      Shelter.where(id: data['id']).exists? ? Shelter.where(id: data['id']).first.update_attributes(data) : Shelter.create(data)
    end
    def add_pets(shelter, pets_data)
      pets_data.each do |pet_data|
        shelter.pets.where(id: pet_data['id']).exists?  ? shelter.pets.where(id: pet_data['id']).first.update_attributes(pet_data) : shelter.pets.create(pet_data)
      end
    end
  end
end
