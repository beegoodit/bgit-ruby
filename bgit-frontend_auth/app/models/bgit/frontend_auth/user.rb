module Bgit
  module FrontendAuth
    class User < ApplicationRecord
      include SimpleFormPolymorphicAssociations::Model::AutocompleteConcern

      if Object.const_defined?("Bgit::Hosting")
        has_many :apps, class_name: "Bgit::Hosting::App", as: :owner, inverse_of: :owner, dependent: :destroy
        has_many :team_memberships, class_name: "Bgit::Hosting::TeamMembership", foreign_key: :member_id, inverse_of: :member, dependent: :destroy
        has_many :teams, class_name: "Bgit::Hosting::Team", through: :team_memberships, source: :team
      end

      if Object.const_defined?("Bgit::Pricing")
        has_many :resources, class_name: "Bgit::Pricing::Resource", as: :owner, inverse_of: :owner, dependent: :restrict_with_error
        has_many :subscriptions, class_name: "Bgit::Pricing::Subscription", as: :owner, inverse_of: :owner, dependent: :restrict_with_error, through: :resources
      end

      if Object.const_defined?("Bgit::Invoicing")
        has_many :invoices, class_name: "Bgit::Invoicing::Invoice", as: :owner, inverse_of: :owner, dependent: :restrict_with_error
      end

      autocomplete scope: ->(matcher) { where("bgit_frontend_auth_users.email LIKE :term", term: "%#{matcher.downcase}%") }, id_method: :id, text_method: :human

      acts_as_authentic do |c|
        c.crypto_provider = ::Authlogic::CryptoProviders::SCrypt
        c.log_in_after_create = true
        c.login_field = :email
      end

      scope :authenticable, -> { where(active: true, confirmed: true, approved: true) }

      def authenticable?
        [active, confirmed, approved].all?
      end

      # Validate email, login, and password as you see fit.
      #
      # Authlogic < 5 added these validation for you, making them a little awkward
      # to change. In 4.4.0, those automatic validations were deprecated. See
      # https://github.com/binarylogic/authlogic/blob/master/doc/use_normal_rails_validation.md
      validates :email,
        format: {
          with: /@/,
          message: "should look like an email address."
        },
        length: {maximum: 100},
        uniqueness: {
          case_sensitive: false,
          if: :will_save_change_to_email?
        }

      # validates :login,
      #   format: {
      #     with: /\A[a-z0-9]+\z/,
      #     message: "should use only letters and numbers."
      #   },
      #   length: { within: 3..100 },
      #   uniqueness: {
      #     case_sensitive: false,
      #     if: :will_save_change_to_login?
      #   }

      validates :password,
        confirmation: {if: :require_password?},
        length: {
          minimum: 8,
          if: :require_password?
        }
      validates :password_confirmation,
        length: {
          minimum: 8,
          if: :require_password?
        }

      def human
        email
      end
    end
  end
end
