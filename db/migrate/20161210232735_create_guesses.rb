class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |t|
      t.integer :height
      t.integer :weight
      t.string :guessvalue
      t.string :actualvalue

      t.timestamps null: false
    end
  end
end
