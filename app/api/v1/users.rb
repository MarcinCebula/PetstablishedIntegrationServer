module V1
  class Users < Grape::API
    format :json
    formatter :json, Grape::Formatter::Rabl

    def get
    end

  end
end
