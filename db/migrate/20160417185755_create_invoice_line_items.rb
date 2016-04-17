class CreateInvoiceLineItems < ActiveRecord::Migration[5.0]
  def change
    create_table :invoice_line_items do |t|
      t.references :project, foreign_key: true
      t.references :invoice, foreign_key: true
      t.decimal :quantity, precision: 4, scale: 2
      t.string :label
      t.monetize :rate, currency: { present: false }

      t.timestamps
    end
  end
end
