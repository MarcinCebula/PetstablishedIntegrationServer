class API < Grape::API
  prefix 'api'
  mount V1::Ping
  prefix 'api/shelter'
  mount V1::Shelter
end
