class CreateInvoices < ActiveRecord::Migration[5.0]
  def change
    create_table :invoices do |t|
      t.string :number
      t.references :client, foreign_key: true
      t.integer :terms
      t.datetime :invoiced_at

      t.timestamps
    end
  end
end
