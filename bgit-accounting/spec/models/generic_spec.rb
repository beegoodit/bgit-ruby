require "rails_helper"

RSpec.describe "ActiveRecord::Base models", type: :model do
  # rubocop:disable Lint/ConstantDefinitionInBlock
  DEFAULT_SPECS_TO_RUN = [
    :is_an_active_record,
    :is_instanciable,
    :valid_with_correct_attributes,
    :not_valid_with_empty_attributes,
    :saves_with_valid_attributes
  ]
  # rubocop:enable Lint/ConstantDefinitionInBlock

  {
    Bgit::Accounting::Accounting::Account => {},
    Bgit::Accounting::Banking::Account => {},
    Bgit::Accounting::Banking::Transfer => {},
    Bgit::Accounting::Contacts::Address => {},
    Bgit::Accounting::Contacts::Company => {},
    Bgit::Accounting::Contacts::ContactPerson => {},
    Bgit::Accounting::Contacts::Contact => {},
    Bgit::Accounting::Contacts::EmailAddress => {},
    Bgit::Accounting::Contacts::Person => {},
    Bgit::Accounting::Contacts::PhoneNumber => {},
    Bgit::Accounting::Contacts::Role => {},
    Bgit::Accounting::Vouchers::Voucher => {},
    Keepr::Account => {factory_name: :account},
    Keepr::CostCenter => {factory_name: :cost_center},
    Keepr::Group => {factory_name: :group},
    Keepr::Journal => {factory_name: :journal},
    Keepr::Posting => {factory_name: :posting},
    Keepr::Tax => {factory_name: :tax}

  }.each do |model, options|
    options.reverse_merge!(specs_to_run: DEFAULT_SPECS_TO_RUN, specs_to_skip: [], factory_name: model.to_s.tableize.singularize.underscore.tr("/", "_"))
    specs_to_run = options.delete(:specs_to_run)
    specs_to_skip = options.delete(:specs_to_skip)
    specs = specs_to_run - specs_to_skip
    factory_name = options.delete(:factory_name)

    describe model do
      if specs.include?(:is_an_active_record)
        describe "is an ActiveRecord::Base" do
          it do
            expect(ActiveRecord::Base.descendants).to include(model)
          end
        end
      end

      if specs.include?(:is_instanciable)
        describe "is instanciable" do
          it do
            instance = model.new
            expect(instance).to be_a(model)
          end
        end
      end

      if specs.include?(:valid_with_correct_attributes)
        describe "is valid with correct attribute values" do
          it do
            instance = build(factory_name)
            instance.valid?
            expect(instance.errors.full_messages).to eq([])
          end
        end
      end

      if specs.include?(:not_valid_with_empty_attributes)
        describe "is not valid with empty attributes" do
          it do
            instance = model.new
            expect(instance).not_to be_valid
          end
        end
      end

      if specs.include?(:saves_with_valid_attributes)
        describe "saves with valid attributes" do
          it do
            instance = build(factory_name)
            expect(instance.save).to be_truthy
            expect(instance).to be_persisted
          end
        end
      end
    end
  end
end
