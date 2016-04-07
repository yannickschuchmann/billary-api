class CreateAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :addresses do |t|
      t.string :line_1
      t.string :line_2
      t.string :locality
      t.string :province
      t.string :postcode
      t.string :country

      t.timestamps
    end
  end
end
