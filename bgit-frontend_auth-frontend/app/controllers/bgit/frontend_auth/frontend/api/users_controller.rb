module Bgit
  module FrontendAuth
    module Frontend
      module Api
        class UsersController < ActionController::API
          # before_action :authenticate_user!
          
          def show
            render json: @resource.as_json(only: [:email])
          end

          private

  #        def authenticate_user!
  #          head(403) unless api_token =~ /[a-f0-9]{32}/
  #
  #          @resource = Frontend::Auth::User.authenticable.where(api_token: api_token).first
  #          
  #          head(403) unless @resource
  #        end
  #
  #        def api_token
  #          @api_token ||= request.headers["Authorization"]&.split(": ").last
  #        end
        end
      end
    end
  end
end
