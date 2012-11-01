module Tanks
  class World < Base
    attr_accessor :tick, :width, :height, :players, :obstacles, :tanks, :shells,
                  :bonuses
  end
end
