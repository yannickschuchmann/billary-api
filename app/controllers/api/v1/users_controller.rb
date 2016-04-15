class API::V1::UsersController < API::V1::ApiController
  # GET /users/current
  def current
    render json: User.last, include: ['company', 'company.payment_address', 'company.address']
  end
end
