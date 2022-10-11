class Decks::CardsController < ApplicationController

  before_action :set_card, only: %i[show edit update destroy]
  before_action :set_deck

  def import
    cards = params[:cards_file]
    return redirect_to deck_cards_url(deck_code: @deck.code), notice: "Only CSV please." unless cards.content_type == "text/csv"
    Decks::CsvImportCardsService.new.call(cards, @deck.id, current_user.id)
    redirect_to deck_cards_url(deck_code: @deck.code), notice: "Cards imported." 
  end

  def index
    @cards = Card.where(deck_id: @deck.id)
  end

  def show
  end

  def new
    @card = Card.new
  end

  def edit
  end

  def create
    @card = @deck.cards.new(card_params)
    @card.user = current_user

    respond_to do |format|
      if @card.save
        format.html { redirect_to deck_cards_url(deck_code: @deck.code), notice: "Card was successfully created." }
        format.json { render :show, status: :created, location: @card }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end

  end

  def update
    respond_to do |format|
      if @card.update(card_params)
        format.html { redirect_to deck_cards_url(deck_code: @deck.code), notice: "Card was successfully updated." }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @card.destroy

    respond_to do |format|
      format.html { redirect_to deck_cards_url(deck_code: @deck.code), notice: "Card was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_deck
      @deck = Deck.find_by_code(params[:deck_code])
    end

    def card_params
      params.require(:card).permit(:question, :description)
    end

    def set_card
      @card = Card.find(params[:id])
    end
    
end