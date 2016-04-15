class API::V1::CompaniesController < API::V1::ApiController
  before_action :set_company, only: [:update]

  # PATCH/PUT /companies/1
  def update
    new_params = company_params
    new_params[:address_attributes][:id] = @company.address_id
    new_params[:payment_address_attributes][:id] = @company.payment_address_id

    if @company.update(new_params)
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
          address_attributes: [:line_1, :line_2, :locality, :province, :postcode, :country],
          payment_address_attributes: [:account_holder, :iban, :bic]
      )
    end
end
