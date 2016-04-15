class PaymentAddress < ApplicationRecord
  self.inheritance_column = nil
  has_one :company

  before_save :set_to_iban

  def set_to_iban
    self.type = "iban"
  end

end
