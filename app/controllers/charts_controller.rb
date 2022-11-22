class ChartsController < ApplicationController

  before_action :set_deck

  def cardscore_by_status
    @cardScores = CardScore.where(user_id: current_user.id, deck_id: @deck.id).group(:status).count
    render json: @cardScores
  end

  private 

    def set_deck
      @deck = Deck.find_by(code: params[:deck_code])
    end

end