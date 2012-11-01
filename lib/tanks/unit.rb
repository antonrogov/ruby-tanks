module Tanks
  class Unit < Base
    attr_accessor :id, :width, :height, :x, :y, :speed_x, :speed_y, :angle,
                  :angular_speed, :type

    def position
      Position.new @x, @y, @angle
    end

    def angle_to(unit)
      position.angle_to unit.x, unit.y
    end

    def distance_to(unit)
      position.distance_to unit.x, unit.y
    end

    private

    def default_values
      { speed_x: 0,
        speed_y: 0,
        angle: 0,
        angular_speed: 0 }
    end
  end
end
