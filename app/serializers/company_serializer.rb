class CompanySerializer < ActiveModel::Serializer
  attributes :id, :name, :name, :web, :email, :phone, :tax_id, :vat_rate

  belongs_to :address, serializer: AddressSerializer
  belongs_to :payment_address, serializer: PaymentAddressSerializer
end
