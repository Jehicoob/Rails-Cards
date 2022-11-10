class DeckScores::CreateOrFindDeckScoreService

  # default attributes that all services should have
  attr_reader :error, :messages, :output

  # custom attributes for what this service does
  attr_reader :user, :deck

  # we receive all parameters in the initialization
  def initialize(user, deck)
    @user = user
    @deck = deck
  end

  def perform
    reinitialize

    @deck_score = DeckScore.create_with(
      score: 0.0,
      qualification: 0.0,
      successful_cards: 0
    ).find_or_create_by(
      user_id: @user.id,
      deck_id: @deck.id,
    )

    if @deck_score.valid?

      @deck_score.save
      @messages << "Deck Score successfully created"
      @output = @deck_score

    else
      @errors << @deck_score.errors.full_messages
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