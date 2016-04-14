class Client < ApplicationRecord
  has_one :address, dependent: :destroy
  belongs_to :user
  accepts_nested_attributes_for :address
end