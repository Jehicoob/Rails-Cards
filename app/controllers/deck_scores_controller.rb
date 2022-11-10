class DeckScoresController < ApplicationController

  before_action :set_deck, only: %i[ get_deck_score get_total_score ]
  before_action :set_deck_score, only: %i[ update ]

  skip_before_action :verify_authenticity_token

  def get_deck_score
    @deck_score = DeckScore.find_by(user_id: current_user.id, deck_id: @deck.id)
    render json: @deck_score
  end

  def get_total_score
    totalScore = CardScore.where(user_id: current_user.id, deck_id: @deck.id).sum(:total_score)
    render json: totalScore
  end

  def update
    @deck_score.update(deck_score_params)

    if @deck_score.save 
      render json: @deck_score
    else
      render json: @deck_score.errors.full_message
    end
    
  end

  private

    def set_deck
      @deck = Deck.find_by(code: params[:deck_code])
    end

    def set_deck_score
      @deck_score = DeckScore.find(params[:deck_score_id])
    end

    def deck_score_params
      params.require(:deck_score).permit(:score, :qualification, :successful_cards)
    end

end