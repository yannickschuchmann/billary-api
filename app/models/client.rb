class Client < ApplicationRecord
  has_one :address, dependent: :destroy
  belongs_to :user
  accepts_nested_attributes_for :address
  has_many :invoices, dependent: :destroy
  has_many :projects
  monetize :rate_cents, with_model_currency: :currency

  def generate_invoice
    invoice = self.invoices.build
    self.projects.top_level.each do |project|
      quantity = project.duration_of_open_time_entries / 60.0 # minutes -> hours
      if quantity > 0
        invoice.line_items << InvoiceLineItem.new({
            project_id: project.id,
            quantity: quantity,
            label: project.name,
            rate: self.rate
                                                  })
        project.mark_open_time_entries_as_invoiced
      end
    end

    invoice.save unless invoice.line_items.empty?
  end
end