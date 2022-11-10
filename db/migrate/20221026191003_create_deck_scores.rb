class CreateDeckScores < ActiveRecord::Migration[6.1]
  def change
    create_table :deck_scores do |t|
      t.references :user, null: false, foreign_key: true
      t.references :deck, null: false, foreign_key: true
      t.float :score
      t.float :qualification
      t.integer :successful_cards

      t.timestamps
    end
  end
end
