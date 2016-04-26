class InvoiceLineItem < ApplicationRecord
  belongs_to :project, optional: true
  belongs_to :invoice

  after_destroy :nullify_time_entries

  def rate
    Money.new(self.rate_cents, self.invoice.client.currency) # depend on clients currency
  end

  private
    def nullify_time_entries
      if self.project_id.present?
        self.invoice.time_entries.where(project_id: self.project_id).update_all(invoice_id: nil)
      end
    end

end
