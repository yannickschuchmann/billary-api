class Client < ApplicationRecord
  has_one :address, dependent: :destroy
  belongs_to :user
  accepts_nested_attributes_for :address

  has_many :invoices

  monetize :rate_cents, with_model_currency: :currency
end