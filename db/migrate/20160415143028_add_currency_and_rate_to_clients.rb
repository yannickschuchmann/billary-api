class AddCurrencyAndRateToClients < ActiveRecord::Migration[5.0]
  def change
    add_column :clients, :currency, :string, default: "EUR"
    add_monetize :clients, :rate, currency: { present: false }
  end
end
