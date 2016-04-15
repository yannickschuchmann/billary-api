class ClientSerializer < ActiveModel::Serializer
  attributes :id, :name, :number, :currency, :created_at
  attribute :rate_without_symbol, key: :rate

  def rate_without_symbol
    object.rate.format(symbol: nil, no_cents_if_whole: true)
  end
  has_one :address, serializer: AddressSerializer
end
