class API::V1::UsersController < API::V1::ApiController
  # GET /users/current
  def current
    render json: current_user, include: ['company', 'company.payment_address', 'company.address']
  end
end
