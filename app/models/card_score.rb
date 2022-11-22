# == Schema Information
#
# Table name: card_scores
#
#  id          :bigint           not null, primary key
#  user_id     :bigint           not null
#  deck_id     :bigint           not null
#  card_id     :bigint           not null
#  total_score :float
#  plays       :integer
#  average     :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  status      :string
#
class CardScore < ApplicationRecord
  belongs_to :user
  belongs_to :deck
  belongs_to :card
end
