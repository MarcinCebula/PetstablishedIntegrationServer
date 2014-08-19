object false

node :index_with_extras do
  {
    :pets => partial("pets/index", :object => @pets),
    :count => @pets.count
  }
end
