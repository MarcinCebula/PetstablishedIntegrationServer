class Pet
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  embedded_in :shelter

  validates_uniqueness_of :uid


end
