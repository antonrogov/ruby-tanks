module Tanks
  module ShellType
    REGULAR = 0
    PREMIUM = 1
  end

  class Shell < Unit
    attr_accessor :player_name
  end
end
