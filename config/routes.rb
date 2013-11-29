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

    resources :comments, :only => [:index, :destroy]
    get "/comments/:film_id" => "comments#film_comments", :as => :film_comments
  end

  resources :votes, :only => [:create]
  
  resources :comments, :only => [:create]

  get "/film_description/:film_id" => "films#film_description", :as => :film_description

  get "/search" => "searches#search", :as => :search
  get "/searchable_films" => "films#searchable_films", :as => :searchable_films


  get "/awards" => "awards#index", :as => :public_awards

  get "/:festival/genres" => "genres#show", :as => :public_genre
  get "/:festival/:slug" => "films#show", :as => :public_film

  get "/:slug" => "festivals#show", :as => :public_festival
end
