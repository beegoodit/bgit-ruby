module Bgit
  module Accounting
    class ApplicationRecord < ActiveRecord::Base
      self.abstract_class = true
    end
  end
end
