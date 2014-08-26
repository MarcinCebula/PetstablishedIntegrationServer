class API < Grape::API
  prefix 'api'
  mount V1::Ping
  prefix 'api/shelter'
  mount V1::Shelter
  prefix 'api/session'
  mount V1::Session
  prefix 'api/registration'
  mount V1::Registration
  prefix 'api/users'
  mount V1::Users
end
