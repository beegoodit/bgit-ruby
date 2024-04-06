module Bgit
  module Accounting
    module Vouchers
      class AssignVoucherService < Rao::Service::Base
        class Result < Rao::Service::Result::Base
          attr_accessor :voucher
        end

        attr_accessor :amounts,
          :description,
          :due_date,
          :account,
          :account_id,
          :type,
          :voucher_date,
          :voucher_id,
          :voucher_number

        validates :amounts,
          :type,
          :voucher,
          :voucher_date,
          :voucher_number, presence: true

        def voucher
          @voucher ||= Voucher.find_by(id: @voucher_id)
        end

        def amounts
          @amounts ||= (voucher&.amounts || [])
        end

        def amounts=(value)
          @amounts = case value
          when Array
            value.collect do |v|
              v.is_a?(Hash) ? Bgit::Accounting::Vouchers::Amount.new(v) : v
            end
          else
            value
          end
        end

        def accountable
          @accountable ||= voucher&.accountable
        end

        private

        def _perform
          assign_voucher_attributes
          assign_amounts
          unless voucher.valid?
            add_error_and_say(:base, voucher.errors.full_messages.join(", "))
          end
          unless amounts.size > 0
            add_error_and_say(:base, "At least one amount must be present.")
          end
          unless amounts.all?(&:valid?)
            add_error_and_say(:base, amounts.map { |a| a.errors.full_messages.join(", ") }.join(", "))
          end
          calculate_voucher_amount
          change_voucher_type
          @result.voucher = voucher
        end

        def assign_amounts
          say "Assigining #{amounts.size} amounts to voucher" do
            amounts.each do |amount|
              amount.voucher = voucher
            end
          end
        end

        def assign_voucher_attributes
          voucher.assign_attributes(
            description: description,
            due_date: due_date,
            voucher_date: voucher_date,
            voucher_number: voucher_number
          )
        end

        def calculate_voucher_amount
          say "Setting the voucher amount to the sum of all amounts gross amounts" do
            voucher.amount = amounts.sum(&:gross_amount)
            say "Voucher amount is now #{voucher.amount} #{voucher.amount.currency}"
          end
        end

        def change_voucher_type
          say "Changing voucher type to #{type}" do
            voucher.type = type
          end
        end

        def save
          ActiveRecord::Base.transaction do
            voucher.save!
            amounts.map(&:save!)
          end
        end
      end
    end
  end
end
