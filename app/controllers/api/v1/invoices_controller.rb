require 'zip'

class API::V1::InvoicesController < API::V1::ApiController
  before_action :set_invoice, only: [:show, :update, :destroy]

  # GET /invoices
  def index
    @invoices = current_user.invoices
    render json: @invoices
  end

  # GET /invoices/1
  def show
    @client = @invoice.client
    @company = @invoice.company
    payment_address = @company.payment_address unless @company.blank?

    respond_to do |format|
      format.pdf do
        render ({
                  pdf: "#{@client.name}-#{@invoice.created_at}",
                  template: 'invoices/show.pdf.erb',
                  encoding: 'UTF-8',
                  margin: { :bottom => 25 },
                  footer: {
                    html: {
                        template: 'invoices/footer.pdf.erb',
                        locals: { payment_address: payment_address }
                    }
                  }
          })
      end
    end
  end

  def generate
    clients = params[:client_ids].present? ? current_user.clients.where(id: params[:client_ids]) : current_user.clients
    invoices = clients.map do |client|
      till = ((params[:till].to_time + 1.day) || Time.now).beginning_of_day
      client.generate_invoice(till)
    end
    invoices.compact!



    response.headers["X-Frame-Options"] = "ALLOWALL"

    unless invoices.blank?
      stringio = Zip::OutputStream.write_buffer do |zio|
        invoices.each do |invoice|
          file_name = "tiktak_invoice-#{invoice.client.name}-#{invoice.created_at.to_i}.pdf"
          pdf = render_to_string({
                   pdf: file_name,
                   template: 'invoices/show.pdf.erb',
                   encoding: 'UTF-8',
                   margin: { :bottom => 25 },
                   locals: {
                       '@invoice': invoice,
                       '@client': invoice.client,
                       '@company': invoice.company
                   },
                   footer: {
                       html: {
                           template: 'invoices/footer.pdf.erb',
                           locals: { payment_address: invoice.company.payment_address }
                       }
                   }
          })
          zio.put_next_entry(file_name)
          zio << pdf
        end
      end
      response.headers["files"] = invoices.length
      stringio.rewind
      send_data(stringio.sysread, :type => 'application/zip', :filename => "tiktak_invoices-#{Time.now.to_i}.zip")
    else
      response.headers["files"] = 0
      head :ok
    end

  end

  # POST /invoices
  def create
    @invoice = Invoice.new(invoice_params)
    if @invoice.user == current_user && @invoice.save
      render json: @invoice, status: :created, location: api_v1_invoice_url(@invoice)
    else
      render json: @invoice.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /invoices/1
  def update
    if @invoice.user == current_user && @invoice.update(invoice_params)
      render json: @invoice
    else
      render json: @invoice.errors, status: :unprocessable_entity
    end
  end

  # DELETE /invoices/1
  def destroy
    @invoice.destroy if @invoice.user == current_user
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def invoice_params
      data = params
                 .fetch(:invoice, {})
                 .permit(:id, :client_id, :number, :terms, :invoiced_at,
                         line_items_attributes: [:id, :quantity, :label, :rate, :_destroy])

      data[:line_items_attributes].map do |line_item|
        line_item[:rate_cents] = (line_item.delete(:rate).to_d.round(4).truncate(2) * 100).to_i
        line_item
      end
      data
    end
end
