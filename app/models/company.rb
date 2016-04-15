class Company < ApplicationRecord
  belongs_to :address
  belongs_to :payment_address
  belongs_to :user
  accepts_nested_attributes_for :payment_address

  validates :name, presence: true
end