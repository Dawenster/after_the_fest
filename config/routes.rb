AfterTheFest::Application.routes.draw do
  root "festivals#index"

  resources :festivals, :only => [:index]
  get "/festivals/:slug" => "festivals#show", :as => :festival

  scope "/admin" do
    get "/" => "admins#index", :as => :admins
    
    resources :festivals, :except => [:index, :show]
    get "/festivals" => "festivals#admin_index", :as => :admin_festivals

  end
end
