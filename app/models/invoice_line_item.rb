class InvoiceLineItem < ApplicationRecord
  belongs_to :project
  belongs_to :invoice

  register_currency :eur
  monetize :rate_cents #, with_model_currency: :currency
end
