module V1
  class Registration < Grape::API
    format :json
    formatter :json, Grape::Formatter::Rabl

    rescue_from Mongoid::Errors::Validations do |e|
      error_response({ message: "rescued from #{e.class.name}" })
    end

    post :confirmation do
    end
    post :register do


      user = User.new(params[:user])


      # Unauthorized
      # error!(message, status = 401, headers = nil)
      # Forbidden
      # error!(message, status = 403, headers = nil)
      # Method Not Allowed
      # error!(message, status = 405, headers = nil)
      # Internal Server Error
      # error!(message, status = 500, headers = nil)


      {
        :token => JWT.encode({
                               "some" => "payload"
                             }, "secret")
      }
    end

  end
end
