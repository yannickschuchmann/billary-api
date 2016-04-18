class InvoiceLineItem < ApplicationRecord
  belongs_to :project
  belongs_to :invoice

  def rate
    Money.new(self.rate_cents, self.invoice.client.currency) # depend on clients currency
  end

end
