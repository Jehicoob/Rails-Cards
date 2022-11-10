class Decks::CreateDeckService

  # default attributes that all services should have
  attr_reader :errors, :messages, :output

  # custom attributes for what this service does
  attr_reader :owner, :deck_params

  # we receive all parameters in the initialization
  def initialize(owner, deck_params)
    @owner = owner
    @params = deck_params
  end

  def perform
    reinitialize

    @deck = Deck.new(@params)
    @deck.owner = User.find(@owner.id)
    @deck.code = "#{@owner.id}#{SecureRandom.hex(4)}"

    if @deck.valid?

      @deck.save
      @messages << "Deck successfully created"
      @output = @deck

    else

      @errors << @deck.errors.full_messages
    
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