class Invoice < ApplicationRecord
  belongs_to :client

  has_many :line_items, foreign_key: "invoice_id", class_name: "InvoiceLineItem", dependent: :destroy
  has_many :projects, through: :line_items
end
