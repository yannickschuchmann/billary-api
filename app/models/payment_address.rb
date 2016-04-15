class PaymentAddress < ApplicationRecord
  self.inheritance_column = nil
  has_one :company
end
