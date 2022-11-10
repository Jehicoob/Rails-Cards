# == Schema Information
#
# Table name: deck_scores
#
#  id               :bigint           not null, primary key
#  user_id          :bigint           not null
#  deck_id          :bigint           not null
#  score            :float
#  qualification    :float
#  successful_cards :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class DeckScore < ApplicationRecord
  belongs_to :user
  belongs_to :deck
end
