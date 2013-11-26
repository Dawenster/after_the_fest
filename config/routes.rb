AfterTheFest::Application.routes.draw do
  root "festivals#index"

  resources :festivals, :only => [:index]

  scope "/admin" do
    get "/" => "admins#index", :as => :admins
    
    resources :festivals, :except => [:index, :show]
    get "/festivals" => "festivals#admin_index", :as => :admin_festivals

    resources :films, :except => [:index, :show]
    get "/films" => "films#admin_index", :as => :admin_films

    resources :genres, :except => [:index, :show]
    get "/genres" => "genres#admin_index", :as => :admin_genres

    resources :awards, :except => [:index, :show]
    get "/awards" => "awards#admin_index", :as => :admin_awards

    resources :locations, :except => [:show]
  end

  resources :votes, :only => [:create]

  get "/genres" => "genres#show", :as => :public_genre
  get "/awards" => "awards#index", :as => :public_awards
  get "/:festival/:slug" => "films#show", :as => :public_film
  get "/:slug" => "festivals#show", :as => :public_festival
end
