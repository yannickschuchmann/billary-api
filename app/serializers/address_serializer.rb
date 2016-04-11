class AddressSerializer < ActiveModel::Serializer
  attributes :id, :line_1, :line_2, :locality, :province, :postcode, :country
end
