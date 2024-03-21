module Bgit
  module FrontendAuth
    module Api
      module Controllers
        # You can secure endpoints so that they can only be accessed with a valid
        # api token. This can be done by including the
        # Cmor::Core::Api::Controllers::TokenAuthenticationConcern to the
        # controller that should be secured:
        #
        #     class ApiController < ActionController::API
        #       include Bgit::FrontendAuth::Api::Controllers::JwtAuthenticationConcern
        #
        #       before_action :authenticate_with_jwt!
        #       # ...
        #     end
        #
        # Sign in to get a valid token:
        #
        #     POST http://localhost:3000/api/auth/login
        #     {
        #       "email": "jane.doe@domain.local",
        #       "password": "Test1234!"
        #     }
        #
        #     Response:
        #
        #     {
        #       "user": {
        #         "id": 1,
        #         "email": "jane.doe@domain.local"
        #       },
        #       "token": "<API_TOKEN>"
        #     }
        #
        #
        # To access secured controllers you have to provide a valid token via the
        # Authorization Header:
        #
        #     GET http://localhost:3000/api/posts
        #     Authorzation: Bearer <API_TOKEN>
        #
        module JwtAuthenticationConcern
          extend ActiveSupport::Concern

          # included do
          #   before_action :authorize_with_jwt!
          # end

          private
          
          def encode_token(payload:, secret:)
            JWT.encode(payload, secret) 
          end
      
          def decoded_token(secret: nil)
            header = request.headers['Authorization']
            if header
              token = header.split(" ")[1]
              begin
                JWT.decode(token, secret, !!secret, algorithm: 'HS256')
              rescue JWT::DecodeError
                nil
              end
            end
          end

          def current_user 
            if decoded_token
              user_id = decoded_token[0]['user_id']
              user = User.find_by(id: user_id)

              if user && decoded_token(secret: user.crypted_password)
                @user = user
              else
                nil
              end
            end
          end
    
          def authenticate_with_jwt!
            unless !!current_user
              render json: { message: 'Please log in' }, status: :unauthorized
            end
          end
        end
      end
    end
  end
end
