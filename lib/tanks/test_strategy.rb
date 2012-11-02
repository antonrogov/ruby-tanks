module Tanks
  class TestStrategy < Struct.new(:index, :team_size)
    MIN_MOVE_ANGLE = Math::PI / 6
    MIN_AIM_ANGLE = Math::PI / 180

    def move(me, world)
      move = Move.new

      enemies = world.tanks.reject {|t| t.teammate || t.health <= 0 }

      if target = enemies.min_by {|t| me.turret_angle_to(t).abs }
        angle = me.turret_angle_to target

        if angle > MIN_AIM_ANGLE
          move.turret_turn = MIN_AIM_ANGLE
        elsif angle < -MIN_AIM_ANGLE
          move.turret_turn = -MIN_AIM_ANGLE
        else
          move.fire_type = FireType::PREMIUM_PREFERRED
        end
      end

      if closest_bonus = world.bonuses.min_by {|bonus| me.distance_to bonus }
        angle = me.angle_to closest_bonus

        if angle > MIN_MOVE_ANGLE
          move.left_track_power = 0.75
          move.right_track_power = -1.0
        elsif angle < -MIN_MOVE_ANGLE
          move.left_track_power = -1.0
          move.right_track_power = 0.75
        else
          move.left_track_power = 1.0
          move.right_track_power = 1.0
        end
      end

      move
    end

    def select_tank_type
      TankType::MEDIUM
    end
  end
end
