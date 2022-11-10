class GamesController < ApplicationController

  before_action :authenticate_user! 
  before_action :set_deck, only: %i[ game result ]

  def game
    @cards = Card.where(deck_id: @deck.id)
  end

  def result
  end

  private

    def set_deck
      @deck = Deck.find_by_code(params[:deck_code])
    end

end