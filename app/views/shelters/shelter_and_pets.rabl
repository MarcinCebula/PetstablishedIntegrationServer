object false

node :shelter_and_pets do
  {
    :shelter => partial("shelters/view", :object => @shelter),
    :pets => partial("pets/index", :object => @pets),
    :pet_count => @shelter.pets.count
  }
end
