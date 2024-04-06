module Bgit
  module Accounting
    module Vouchers
      class BulkUploadService < Rao::Service::Base
        class Result < Rao::Service::Result::Base
          attr_accessor :vouchers
        end

        attr_accessor :accountable_id, :accountable_type, :assets

        def accountable
          @accountable ||= accountable_type&.constantize&.find(accountable_id)
        end

        private

        def _perform
          @result.vouchers = build_unchecked_vouchers
        end

        def build_unchecked_vouchers
          assets.filter { |a| !a.is_a?(String) }.collect do |asset|
            Bgit::Accounting::Vouchers::Unchecked.build(accountable: accountable).tap do |uv|
              uv.asset.attach(asset)
            end
          end
        end

        def save
          ActiveRecord::Base.transaction do
            @result.vouchers.map(&:save!)
          end
        end
      end
    end
  end
end
