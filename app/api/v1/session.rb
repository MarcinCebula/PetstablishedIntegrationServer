module V1
  class Session < Grape::API
    format :json
    formatter :json, Grape::Formatter::Rabl

    def user
    end

  end
end
