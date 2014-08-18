module V1
  class Shelter < Grape::API
    format :json
    formatter :json, Grape::Formatter::Rabl

    post :add_pets_to_organization, :rabl => 'shelters/add_pets_to_organization' do
      @id = params['integration']['organization_id']
      @count = params['integration']['fetch_count']
      error!('Missing paramters. Please fill in form before submitting.', 400) if @id.to_s.empty? || @count.to_s.empty?
      begin
        @shelter = PetfinderManager.store_only_cats_and_dogs_for_organization(@id, @count)
      rescue
        error!('Server is experiencing problems. Please try again', 400)
      end
      # @shelter
      @shelter = ::Shelter.first
    end

    get :index, :rabl => 'shelters/index' do
      @shelters = ::Shelter.all.paginate(:page => params['page'], :limit => 25).order_by('pets DESC')
    end

    get ':shelter_url_id/pets', :rabl => 'shelters/shelter_and_pets' do
      @shelter = ::Shelter.where({ url_id: params['shelter_url_id'] }).first
      @pets = @shelter.pets.paginate(:page => params['page'], :limit => 25)
    end
  end
end
