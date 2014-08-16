module V1
  class Ping < Grape::API
    format :json
    formatter :json, Grape::Formatter::Rabl

    get :ping do
      { :ping => params[:pong] || 'pong' }
    end
  end
end
