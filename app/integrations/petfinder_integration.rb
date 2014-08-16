require 'petfinder/models/pet'
require 'petfinder/models/shelter'

module PetfinderIntegration
  class << self
    attr_accessor :key
  end

  def self.configure
    yield self
  end
end
