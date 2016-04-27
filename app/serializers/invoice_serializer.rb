class InvoiceSerializer < ActiveModel::Serializer
  attributes :id, :number, :terms, :created_at, :invoiced_at, :client_id
  attribute :price_without_symbol, key: :price

  def price_without_symbol
    object.price.format(symbol: nil, no_cents_if_whole: true)
  end
  has_one :client, serializer: ClientSerializer
  has_many :line_items, serializer: InvoiceLineItemSerializer

end
