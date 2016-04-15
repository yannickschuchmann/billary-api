class CreatePaymentAddresses < ActiveRecord::Migration[5.0]
  def change
    create_table :payment_addresses do |t|
      t.string :type
      t.string :account_holder
      t.string :iban
      t.string :bic

      t.timestamps
    end
  end
end
