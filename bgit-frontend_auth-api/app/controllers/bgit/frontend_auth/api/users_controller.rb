module Bgit
  module FrontendAuth
    module Api
      class UsersController < ApplicationController
        wrap_parameters :user, include: [:email, :password]
        skip_before_action :authenticate_with_jwt!, only: [:create]
        rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record
    
        def create 
          user = Bgit::FrontendAuth::User.create!(user_params.merge(password_confirmation: user_params[:password]))
          @token = encode_token(payload: { user_id: user.id }, secret: user.crypted_password)
          render json: {
            user: UserSerializer.new(user), 
            token: @token
          }, status: :created
        end
    
        def current 
          render json: current_user, status: :ok
        end
    
        private
    
        def user_params 
          params.require(:user).permit(:email, :password)
        end
    
        def handle_invalid_record(e)
          render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
        end
      end
    end
  end
end
