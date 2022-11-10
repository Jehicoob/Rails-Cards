class CreateCardScores < ActiveRecord::Migration[6.1]
  def change
    create_table :card_scores do |t|
      t.references :user, null: false, foreign_key: true
      t.references :deck, null: false, foreign_key: true
      t.references :card, null: false, foreign_key: true
      t.float :total_score
      t.integer :plays
      t.float :average

      t.timestamps
    end
  end
end
