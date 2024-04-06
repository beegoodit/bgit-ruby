module Bgit
  module Accounting
    module Banking
      class AssignTransferService < Rao::Service::Base
        class Result < Rao::Service::Result::Base
          attr_accessor :transfer, :vouchers, :transfer_vouchers
        end

        attr_accessor :transfer_id, :transfer, :transfer_vouchers

        validates :transfer, presence: true

        def transfer
          @transfer ||= Transfer.find_by(id: @transfer_id)
        end

        def vouchers
          @vouchers ||= Bgit::Accounting::Vouchers::Voucher.where.not(type: Bgit::Accounting::Vouchers::Unchecked.name).all
        end

        def transfer_vouchers=(value)
          @transfer_vouchers = case value
          when Array
            value.collect do |v|
              v.is_a?(Hash) ? TransferVoucher.new(v) : v
            end
          else
            value
          end
        end

        def transfer_vouchers
          @transfer_vouchers ||= vouchers.collect { |v| transfer.transfer_vouchers.build(voucher_id: v.id) }
        end

        private

        def _perform
          @result.transfer = transfer
          @result.vouchers = vouchers
          @result.transfer_vouchers = build_transfer_vouchers
          unless @result.transfer_vouchers.all?(&:valid?)
            add_error_and_say(:base, @result.transfer_vouchers.map { |a| a.errors.full_messages.join(", ") }.join(", "))
          end
        end

        def build_transfer_vouchers
          say "Building #{vouchers.size} transfer vouchers" do
            vouchers.collect do |voucher|
              TransferVoucher.new(voucher: voucher, transfer: transfer)
            end
          end
        end

        def save
          ActiveRecord::Base.transaction do
            @result.transfer_vouchers.map(&:save!)
          end
        end
      end
    end
  end
end
