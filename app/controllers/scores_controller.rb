class ScoresController < ApplicationController

  before_action :authenticate_user!

  before_action :set_deck, only: %i[ get_cards ]

  before_action :set_score, only: %i[ update ]

  skip_before_action :verify_authenticity_token

  def get_cards
    @cards = Card.where(deck_id: @deck)
    render json: @cards
  end

  def get_score

    @score = Score.where(card_id: params[:card_id], user_id: current_user.id).first
    
    if @score.nil?

      pp "Dentro del if"
      
      @score = Score.create(
        user_id: current_user.id,
        card_id: params[:card_id],
        sum_total: 0,
        plays: 0,
        prom: 0
      )

    end

    render json: @score
  end

  def update
    pp @score
    @score.update(score_params)
    render json: @score
  end

  private

    def set_score
      @score = Score.find_by(id: params[:score_id])
    end
          
    def set_deck
      @deck = Deck.where(code: params[:deck_code])
    end

    def score_params
      params.require(:score).permit(:sum_total, :plays, :prom)
    end

end