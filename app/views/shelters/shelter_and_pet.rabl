object false

node :shelter_and_pet do
  {
    :shelter => partial("shelters/view", :object => @shelter),
    :pet => partial("pets/index", :object => @pet)
  }
end
