module Bgit
  module FrontendAuth
    module Api
      class SessionsController < ApplicationController
        skip_before_action :authenticate_with_jwt!, only: [:create]
        rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
    
        def create
          @user = User.find_by!(email: session_params[:email])
          if @user.valid_password?(session_params[:password])
            @token = encode_token(payload: { user_id: @user.id }, secret: @user.crypted_password)
            render json: {
              user: UserSerializer.new(@user),
              token: @token
            }, status: :accepted
          else
            render json: {message: 'Incorrect password'}, status: :unauthorized
          end
        end
    
        private 
    
        def session_params
          params.require(:session).permit(:email, :password)
        end
    
        def handle_record_not_found(e)
          render json: { message: "User doesn't exist" }, status: :unauthorized
        end
      end
    end
  end
end
