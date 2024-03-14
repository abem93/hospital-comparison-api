class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params['email'])
    if user&.authenticate(params['password'])
      token = jwt_encode(user_id: user.id)
      render json: { token: token , status: :ok}
    else
      render json: { error: 'Unauthorized', status: :unauthorized}
    end
  end

  def jwt_encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, Rails.application.secret_key_base)
  end
end
