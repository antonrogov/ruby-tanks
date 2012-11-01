module Tanks
  class Base
    def initialize(data = {})
      default_values.merge(data).each do |name, value|
        send "#{name}=", value
      end
    end

    def default_values
      {}
    end
  end
end
