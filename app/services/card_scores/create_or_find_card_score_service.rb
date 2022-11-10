class CardScores::CreateOrFindCardScoreService

  # default attributes that all services should have
  attr_reader :error, :messages, :output

  # custom attributes for what this service does
  attr_reader :user, :deck, :card

  # we receive all parameters in the initialization
  def initialize(user, deck, card)
    @user = user
    @deck = deck
    @card = card
  end

  def perform
    reinitialize

    @card_score = CardScore.create_with(
      total_score: 0.0,
      plays: 0,
      average: 0.0
    ).find_or_create_by(
      user_id: @user.id,
      deck_id: @deck.id,
      card_id: @card.id
    )

    if @card_score.valid?

      @card_score.save
      @messages << "Deck Score successfully created"
      @output = @card_score

    else
      @errors << @card_score.errors.full_messages
    end
    
    @errors.empty?
  end


  private
  
    # this just makes sure that each time perform is called the errors and
    # messages are reinitialized
    def reinitialize
      @errors = []
      @messages = []
      @output = nil
    end

end