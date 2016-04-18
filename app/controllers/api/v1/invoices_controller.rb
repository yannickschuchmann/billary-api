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
    payment_address = @company.payment_address

    respond_to do |format|
      format.html
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

  # POST /invoices
  def create
    @invoice = Invoice.new(invoice_params)

    if @invoice.save
      render json: @invoice, status: :created, location: @invoice
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
      params.fetch(:invoice, {})
    end
end
