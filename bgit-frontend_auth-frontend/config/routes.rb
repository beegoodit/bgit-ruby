Bgit::FrontendAuth::Frontend::Engine.routes.draw do
  localized do
    scope :bgit_frontend_auth_frontend_engine do
      resource :user, only: [:show, :edit, :update]
      resource :user, only: [:new, :create] if Bgit::FrontendAuth::Frontend::Configuration.enable_registrations
      resource :user, only: [:destroy] if Bgit::FrontendAuth::Frontend::Configuration.allow_users_to_destroy_self

      resource :user_session, only: [:new, :create, :destroy]

      resource :password_reset_request, only: [:new, :create]
      resource :password_reset, only: [] do
        get "edit/:token" => "password_resets#edit", constraint: { token: /\d+/ }, as: :edit
        match "/:id/:token" => "password_resets#update", constraint: { token: /\d+/ }, as: :update, via: [:put, :patch]
      end

      root to: "home#index"
    end
  end
end
