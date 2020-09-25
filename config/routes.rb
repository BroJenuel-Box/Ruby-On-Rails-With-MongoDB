Rails.application.routes.draw do
  namespace :api do

    namespace :auth do
      post 'login', action: :login, controller: :auth
      post 'check_token', action: :checkToken, controller: :auth
    end

    namespace :v1 do
      get 'get_users', action: :getUsers, controller: :users
      post 'add_user', action: :addUser, controller: :users
      get 'show_user', action: :showUser, controller: :users
      put 'update_user', action: :updateUser, controller: :users
      delete 'delete_user', action: :deleteUser, controller: :users
    end
  end
end
