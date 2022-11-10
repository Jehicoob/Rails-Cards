class CardScoresController < ApplicationController
  
  before_action :authenticate_user!

  before_action :set_deck, only: %i[ get_cards get_score ]
  before_action :set_card, only: %i[ get_score ]
  before_action :set_score, only: %i[ update ]

  skip_before_action :verify_authenticity_token

  def get_cards
    @cards = Card.where(deck_id: @deck.id)
    render json: @cards
  end

  def get_score

    service = CardScores::CreateOrFindCardScoreService.new(current_user, @deck, @card)

    if service.perform
      render json: service.output
    else
      render json: service.errors
    end
  
  end

  def update
    @card_score.update(card_score_params)
    render json: @card_score
  end

  private

    def set_score
      @card_score = CardScore.find(params[:score_id])
    end

    def set_card
      @card = Card.find(params[:card_id])
    end
          
    def set_deck
      @deck = Deck.find_by(code: params[:deck_code])
    end

    def card_score_params
      params.require(:card_score).permit(:total_score, :plays, :average)
    end

end