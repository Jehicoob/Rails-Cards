# == Schema Information
#
# Table name: cards
#
#  id          :bigint           not null, primary key
#  question    :text
#  description :text
#  deck_id     :bigint           not null
#  user_id     :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Card < ApplicationRecord
  belongs_to :deck
  belongs_to :user

  has_one :score, dependent: :destroy

  has_one_attached :img_question, dependent: :destroy
  has_one_attached :img_answer, dependent: :destroy


  validates :question, :description, presence: true
end