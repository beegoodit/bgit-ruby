module Bgit
  module Accounting
    module Contacts
      class ContactsController < Cmor::Core::Backend::ResourcesController::Base
        def self.resource_class
          Bgit::Accounting::Contacts::Contact
        end

        def self.engine_class
          Bgit::Accounting::Engine
        end

        private

        def permitted_params
          params.require(:contacts_contact).permit(
            :name,
            :note,
            company_attributes: [
              :tax_number,
              :vat_identifier,
              addresses_attributes: [
                :role,
                :supplement,
                :street,
                :zip_code,
                :city,
                :country_code,
                :_destroy
              ],
              contact_people_attributes: [
                :primary,
                :salutation,
                :firstname,
                :lastname,
                :email,
                :phone
              ],
              email_addresses_attributes: [
                :role,
                :email
              ],
              phone_numbers_attributes: [
                :role,
                :number
              ]
            ]
          )
        end
      end
    end
  end
end
