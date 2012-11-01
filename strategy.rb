require_relative 'lib/tanks'

module Tanks
  class Strategy < Struct.new(:index, :team_size)
    def move(tank, world)
      Move.new left_track_power: 1.0,
               right_track_power: 1.0,
               turret_turn: Math::PI,
               fire_type: FireType::PREMIUM_PREFERRED
    end

    def select_tank_type
      TankType::MEDIUM
    end
  end
end

Tanks.run Tanks::Strategy, ARGV[1], ARGV[2], ARGV[3]
