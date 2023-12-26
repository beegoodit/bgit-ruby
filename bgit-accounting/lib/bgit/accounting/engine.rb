module Bgit
  module Accounting
    class Engine < ::Rails::Engine
      isolate_namespace Bgit::Accounting
    end
  end
end
