class PaymentAddressSerializer < ActiveModel::Serializer
  attributes :type, :account_holder, :iban, :bic
end
