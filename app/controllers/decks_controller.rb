class DecksController < ApplicationController

  before_action :authenticate_user! 
  before_action :set_deck, only: %i[ show edit update destroy game]
  before_action :set_category, only: %i[ show ]

  def index
    @decks = Deck.where(owner_id: current_user.id)
  end

  def show
    @cards = Card.where(deck_id: @deck.id)
  end

  def new
    @deck = Deck.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
  end

  def create
    @deck = Deck.new(deck_params)
    @deck.owner = current_user
    respond_to do |format|
      if @deck.save
        format.html { redirect_to deck_url(@deck), notice: "Deck was successfully created." }
        DeckMailer.with(deck: @deck).deck_created.deliver_now
        format.json { render :show, status: :created, location: @deck }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @deck.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @deck.update(deck_params)
        format.html { redirect_to deck_url(@deck), notice: "Deck was successfully updated." }
        format.json { render :show, status: :ok, location: @deck }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @deck.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @deck.destroy

    respond_to do |format|
      format.html { redirect_to decks_url, notice: "Deck was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def game
    @cards = Card.where(deck_id: @deck.id)
  end

  private

    def set_deck
      @deck = Deck.find_by_code(params[:code] ||= params[:deck_code])
    end

    def set_category
      @category = Category.find_by_id(@deck.category_id)
    end

    def deck_params
      params.require(:deck).permit(:name, :description, :category_id, :deck_color, :font_color)
    end
end
