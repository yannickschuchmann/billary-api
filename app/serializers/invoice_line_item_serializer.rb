class InvoiceLineItemSerializer < ActiveModel::Serializer
  attributes :id, :quantity, :label
  attribute :rate_without_symbol, key: :rate

  def rate_without_symbol
    object.rate.format(symbol: nil, no_cents_if_whole: true)
  end

end
