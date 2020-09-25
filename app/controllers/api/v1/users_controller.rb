class Api::V1::UsersController < ApplicationController
     before_action :getUser, only: [:updateUser, :deleteUser, :showUser]

     before_action only: [:updateUser, :deleteUser] do
          check_token(2)
     end
     
     # get
     def getUsers

          limit = params[:limit] ? params[:limit] : 10
          page = params[:page] ? params[:page] : 1

          offset = page == 1 ? 0 : (limit.to_i * page.to_i) - (limit.to_i)

          query = [
               {
                    :username => /.*#{params[:search]}.*/
               },
               {
                    :email => /.*#{params[:search]}.*/
               },
               {
                    :id => params[:search]
               }
          ]

          users = User.any_of(query).limit(limit).offset(offset).order('id DESC').map do |u|
               u.as_json({
                    :except => [:password_digest, :_id, :token]
               }).merge({
                    id: u._id.to_s
               })
          end

          if users
               render json: { :limit => limit, :page => page, data: users, count: User.count  }, status: :ok
          else
               render json: { msg: "user Empty" }, status: :unprocessable_entity
          end
     end

     # post
     def addUser
          user = User.new(userparams)
          user.type = 2; # eveytime a user is created a type is will be default as 2

          if user.save()
               render json: user.as_json({:except => [:password_digest]}).merge({:id => user.id.to_s}), status: :ok
          else
               render json: { msg: "User not added", error: user.errors }, status: :unprocessable_entity
          end

     end

     # show
     def showUser
          if @user
               render json: @user, status: :ok
          else
               render json: { msg: "User not Found" }, status: :unprocessable_entity
          end
     end

     # put
     def updateUser
          if @user
               if @user.update(userparams)
                    render json: @user, status: :ok
               else
                    render json: { msg:"Update Failed", error: @user.errors }, status: :unprocessable_entity
               end
          else
               render json: { msg: "User not Found" }, status: :unprocessable_entity
          end
     end

     # delte
     def deleteUser
          if @user
               if @user.destroy()
                    render json: { msg: "User deleted" }, status: :ok
               else
                    render json: { msg:"Update Failed" }, status: :unprocessable_entity
               end
          else
               render json: { msg: "User not Found" }, status: :unprocessable_entity
          end
     end

     private
          def userparams
               params.permit(:username, :email, :password);
          end

          def getUser
               @user = User.find(params[:id])
          end

end
