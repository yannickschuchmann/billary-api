class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :web
      t.string :email
      t.string :phone
      t.string :tax_id
      t.decimal :vat_rate
      t.references :address, foreign_key: true
      t.references :payment_address, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
