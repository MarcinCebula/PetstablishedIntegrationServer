object false

node :index_with_extras do
  {
    :shelters => partial("shelters/index", :object => @shelters),
    :count => @shelters.count
  }
end
