module Bgit::Invoicing
  class ApplicationRecord < ActiveRecord::Base
    include Bgit::Invoicing::Model::UuidConcern

    self.abstract_class = true
  end
end
