Rails.application.routes.draw do

  devise_for :users

  resources :card_scores, only: %i[ update ]
  get "/get_cards" => "card_scores#get_cards"
  get "/get_score" => "card_scores#get_score"

  resources :favorites, only: %i[ index create destroy ], param: :deck_id
  
  resources :categories
  
  resources :accounts, only: %i[ show edit update destroy ]
  
  resources :deck_scores, only: %i[ update ]
  get "/get_deck_score" => "deck_scores#get_deck_score"
  get "/get_total_score" => "deck_scores#get_total_score"

  resources :decks, param: :code do
    resources :cards, controller: "decks/cards" do
      collection do
        post :import 
      end
    end
  end

  root 'welcome#index'

  get '/user' => "decks#index", :as => :user_root

  get "/search_all" => "search#search_all"

  get '/game' => "games#game"

  get "/result" => "games#result"

  # namespace :charts do
  #   get "get_scores"
  # end

  resources :charts, only: [] do
    collection do
      get 'cardscore_by_status'
    end
  end
  
end