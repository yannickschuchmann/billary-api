class InvoiceSerializer < ActiveModel::Serializer
  attributes :id, :number, :terms, :created_at, :invoiced_at
  attribute :price_without_symbol, key: :price

  def price_without_symbol
    object.price.format(symbol: nil, no_cents_if_whole: true)
  end
  has_one :client, serializer: ClientSerializer
end
