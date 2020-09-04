class Api::Auth::AuthController < ApplicationController
  def login
    user = User.find_by(:username => params[:username])

    # check user if exist
    if !user
      render json: { msg: 'Username Doesnt exist' }, status: :unprocessable_entity
      return true;
    end

    if user.authenticate(params[:password])
      token = self.create_token(user.id.to_s, user.username, user.type.to_s)
      user.set(:token => token)
      
      render json: { msg: 'Success Login', user: user.as_json({ :except => [:password_digest] }) }, status: :ok

    else
      render json: { msg: 'pasword wrong' }, status: :unprocessable_entity
    end

  end
end
