# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
# # redirect_to Something_path

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :decks
  has_many :cards
  has_many :deck_scores, dependent: :destroy
  has_many :card_scores, dependent: :destroy
  has_many :favorites, dependent: :destroy 
  has_one :account, dependent: :destroy

  after_create :set_account

  def set_account
    self.account = Account.create(
      username: self.email.split("@")[0],
      nickname: self.email.split("@")[0],
      birth: Date.today
    )
  end

end
