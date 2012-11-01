module Tanks
  class Tank < Unit
    attr_accessor :player_name, :teammate_index, :teammate, :health, :durability,
                  :turret_relative_angle, :premium_shell_count, :reloading_time,
                  :remaining_reloading_time

    def turret_position
      Position.new @x, @y, @angle + @turret_relative_angle
    end

    def turret_angle_to(unit)
      turret_position.angle_to unit.x, unit.y
    end
  end
end
