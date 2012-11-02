module Tanks
  class Position < Struct.new(:x, :y, :angle)
    def angle_to(x, y)
      absolute = Math.atan2 y - self.y, x - self.x
      relative = absolute - self.angle
      relative -= 2.0 * Math::PI while relative > Math::PI
      relative += 2.0 * Math::PI while relative < -Math::PI
      relative
    end

    def distance_to(x, y)
      Math.hypot x - self.x, y - self.y
    end
  end
end
