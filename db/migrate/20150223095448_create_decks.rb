class CreateDecks < ActiveRecord::Migration
  def change
    create_table :decks do |t|
      t.string :name
      t.text :description
      t.text :condition
      t.float :price
      t.json :cards

      t.timestamps null: false
    end

    create_table :cards do |t|
      t.references :deck
      t.string :name
      t.json :data
      t.integer :times
      t.integer :multiverse_id
      t.text :colors

      t.timestamps null: false
    end
  end
end
