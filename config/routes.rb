AfterTheFest::Application.routes.draw do
  root "festivals#index"

  resources :festivals, :only => [:index]

  get "/about-us" => "pages#about_us", :as => :about_us
  get "/contact-us" => "pages#contact_us", :as => :contact_us
  get "/terms-and-conditions" => "pages#terms_and_conditions", :as => :terms_and_conditions

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

    resources :key_inputs, :only => [:update]
    get "/about" => "key_inputs#about_edit", :as => :about_edit
    get "/terms" => "key_inputs#terms_edit", :as => :terms_edit
    get "/vote_messages" => "key_inputs#vote_messages", :as => :vote_messages_edit
    get "/blocked_images" => "key_inputs#blocked_images", :as => :blocked_images_edit
  end

  resources :votes, :only => [:create]
  
  resources :comments, :only => [:create]

  get "/film_description/:film_id" => "films#film_description", :as => :film_description

  get "/search" => "searches#search", :as => :search
  get "/searchable_films" => "films#searchable_films", :as => :searchable_films


  get "/:festival/awards" => "awards#index", :as => :public_awards

  get "/:festival/genres" => "genres#show", :as => :public_genre
  get "/:festival/:slug" => "films#show", :as => :public_film

  get "/:slug" => "festivals#show", :as => :public_festival
end
