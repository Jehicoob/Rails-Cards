class SearchController < ApplicationController

  before_action :authenticate_user! 

  def search_all
    @term = params[:term]
    # raise @term.to_yaml
    @decks = Deck.where("name like ? or description like ? and owner_id = ?", "%#{@term}%", "%#{@term}%", current_user.id)
    @cards = Card.where("question like ? or description like ? and user_id = ?","%#{@term}%","%#{@term}%", current_user.id)
  end

  def search_code

  end
  
end