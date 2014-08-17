class Shelter
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  embeds_many :pets

  validates_uniqueness_of :uid



end
