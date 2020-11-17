class CreateGuesses < ActiveRecord::Migration[6.0]
  def change
    create_table :guesses do |t|
      t.integer :total_guesses
      t.integer :correct_guesses

      t.timestamps
    end
  end
end
