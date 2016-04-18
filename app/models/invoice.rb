class Invoice < ApplicationRecord
  belongs_to :client
  has_many :line_items, foreign_key: "invoice_id", class_name: "InvoiceLineItem", dependent: :destroy
  has_many :projects, through: :line_items
  has_one :user, through: :client
  has_one :company, through: :user

  def price_without_vat
    Money.new(self.line_items.sum("rate_cents * quantity"), self.client.currency)
  end

  def vat
    self.price_without_vat * (self.company.vat_rate / 100)
  end

  def price
    self.price_without_vat + self.vat
  end
end