module Bgit
  module FrontendAuth
    module Api
      class ApplicationController < ActionController::API
        include Bgit::FrontendAuth::Api::Controllers::JwtAuthenticationConcern
        
        before_action :authenticate_with_jwt!

        # rescue standard errors and return a json response
        rescue_from StandardError do |e|
          if Rails.env.development? || Rails.env.test?
            render json: { message: e.message, application_trace: e.backtrace }, status: :internal_server_error
          else
            render json: { message: "Internal Server Error" }, status: :internal_server_error
          end
        end
      end
    end
  end
end
