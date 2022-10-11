class Decks::CsvImportCardsService

  require "csv"

  def call(cards, deck_id, user_id)
    cards = File.open(cards)
    csv = CSV.parse(cards, headers: true)

    csv.each do |card|
      card_hash = {}
      card_hash[:question] = card["question"]
      card_hash[:description] = card["description"]
      card_hash[:deck_id] = deck_id
      card_hash[:user_id] = user_id

      Card.create(card_hash)
    end
  end

end