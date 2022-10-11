Rails.application.routes.draw do

  devise_for :users

  resources :scores, only: %i[ get_cards update get_score ]

  get "/get_cards" => "scores#get_cards"
  
  get "/get_score" => "scores#get_score"

  resources :favorites, only: %i[ index create destroy ], param: :deck_id

  resources :categories

  resources :accounts, only: %i[ show edit update destroy ]

  resources :decks, param: :code do

    resources :cards, controller: "decks/cards" do

      collection do
  
        post :import
  
      end

    end

    get '/game' => "decks#game"

  end

  root 'welcome#index'

  get '/user' => "decks#index", :as => :user_root
  
end