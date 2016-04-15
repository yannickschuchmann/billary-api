class API::V1::CompaniesController < API::V1::ApiController
  before_action :set_company, only: [:update]

  # GET /companies
  def index
    @companies = Company.all

    render json: @companies
  end

  # PATCH/PUT /companies/1
  def update
    if @company.update(company_params)
      render json: @company
    else
      render json: @company.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = current_user.company
    end

    # Only allow a trusted parameter "white list" through.
    def company_params
      params.fetch(:company, {}).permit(
          :name,
          :web, :email, :phone,
          :tax_id, :vat_rate,
          address_attributes: [:id, :line_1, :line_2, :locality, :province, :postcode, :country],
          payment_address_attributes: [:id, :account_holder, :iban, :bic]
      )
    end
end
