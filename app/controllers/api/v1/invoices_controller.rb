require 'zip'

class API::V1::InvoicesController < ActionController::Base
  before_action :set_invoice, only: [:show, :update, :destroy]

  # GET /invoices
  def index
    @invoices = Invoice.all

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
    clients = params[:client_ids].present? ? Client.where(id: params[:client_ids]) : Client.all
    invoices = clients.map do |client|
      client.generate_invoice
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
      stringio.rewind
      send_data(stringio.sysread, :type => 'application/zip', :filename => "tiktak_invoices-#{Time.now.to_i}.zip")
    else
      head :ok
    end

  end

  # POST /invoices
  def create
    @invoice = Invoice.new(invoice_params)

    if @invoice.save
      render json: @invoice, status: :created, location: api_v1_invoice_url(@invoice)
    else
      render json: @invoice.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /invoices/1
  def update
    if @invoice.update(invoice_params)
      render json: @invoice
    else
      render json: @invoice.errors, status: :unprocessable_entity
    end
  end

  # DELETE /invoices/1
  def destroy
    @invoice.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def invoice_params
      params.fetch(:invoice, {}).permit(:id, :number, :terms, :invoiced_at, line_items_attributes: [:id, :quantity, :label, :rate])
    end
end
