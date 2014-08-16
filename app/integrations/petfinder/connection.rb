module PetfinderIntegration
  module Connection
    def self.get(api_method, params)
      params['format'] = 'json'
      params['key'] = PetfinderIntegration.key

      conn = exec(PetfinderIntegration.endpoint, api_method, params)
      conn.get.body
    end
    private
    def exec(endpoint, api_method, params)
      Faraday.new(endpoint + "/#{api_method}", params: params) do |faraday|
        faraday.adapter :excon
      end
    end
  end
end
