class AddStatusToCardScore < ActiveRecord::Migration[6.1]
  def change
    add_column :card_scores, :status, :string
  end
end
