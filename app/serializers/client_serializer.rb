class ClientSerializer < ActiveModel::Serializer
  attributes :id, :name, :number, :created_at

  has_one :address, serializer: AddressSerializer
end
