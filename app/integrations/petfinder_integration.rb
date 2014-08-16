require 'petfinder/models/pet'
require 'petfinder/models/shelter'
require 'petfinder/query'
require 'petfinder/connection'

module PetfinderIntegration
  class << self
    attr_accessor :key
    def endpoint
      'http://api.petfinder.com'
    end
  end

  def self.configure
    yield self
  end
end
