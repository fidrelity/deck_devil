class CreateShippingOptions < ActiveRecord::Migration
  def change
    create_table :shipping_options do |t|
      t.references :deck, index: true
      t.string :region_code
      t.float :value

      t.timestamps null: false
    end
  end
end
