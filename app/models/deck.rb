# == Schema Information
#
# Table name: decks
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  category_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  owner_id    :bigint           not null
#  code        :string
#  font_color  :string
#  deck_color  :string
#
class Deck < ApplicationRecord

  belongs_to :category
  belongs_to :owner, class_name: "User"

  has_many :cards, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :deck_scores, dependent: :destroy
  has_many :card_scores, dependent: :destroy

  validates :name, :description, presence: true
  validates :name, uniqueness: { case_insensitive: false }

  # before_create :create_code

  # def create_code
  #   self.code = "#{owner_id}#{SecureRandom.hex(4)}"
  # end

  def to_param
    code
  end

end
