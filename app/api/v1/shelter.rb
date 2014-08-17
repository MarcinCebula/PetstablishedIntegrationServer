module V1
  class Shelter < Grape::API
    format :json
    formatter :json, Grape::Formatter::Rabl


    post :add do
      response = ShelterManager.add(params[:id])
      if(response.status == 'success')
        ## return
      else
        ## return Error View
      end
    end
  end
end
