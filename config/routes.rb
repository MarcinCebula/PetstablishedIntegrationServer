Rails.application.routes.draw do
  devise_for :users


  root to: "private#index"
  get 'private_page', to: 'private#index'


  devise_scope :user do
    get "sign_out", to: "devise/registrations#destroy"
  end


  mount API => '/'
end
