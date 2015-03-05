class CreateDecks < ActiveRecord::Migration
  def change
    create_table :decks do |t|
      t.string :name
      t.text :description
      t.string :condition_from
      t.string :condition_to
      t.float :price
      t.json :data
      t.text :cards_list

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
