require 'TokenManager'

class ApplicationController < ActionController::API
     include TokenManager

     def create_token(user_id, username, user_type)
          return generate_token(user_id, username, user_type)
     end

     def check_auth(user_type = 1, return_user = false)
          user_token = decrypt_token(request.headers['token'])
          if user_token
               account = User.find(user_token[:id])
               if account
                    if user_token[:token_ex] < Time.now.to_i
                         render json: { msg: 'Token Expired' }, status: :unauthorized
                    else
                         if return_user
                              render json: { msg: 'Token Authorized', user: account }, status: :ok
                         else
                              return true;
                         end
                    end
               else
                    render json: { msg: 'Unauthorized' }, status: :unauthorized
               end
          else
               render json: { msg: 'Unauthorized, Token Unacceptable' }, status: :unauthorized
          end
     end

end
