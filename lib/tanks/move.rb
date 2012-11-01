module Tanks
  module FireType
    NONE = 0
    REGULAR = 1
    PREMIUM = 2
    PREMIUM_PREFERRED = 3
  end

  class Move < Base
    attr_accessor :left_track_power, :right_track_power, :turret_turn, :fire_type

    private

    def default_values
      { left_track_power: 0,
        right_track_power: 0,
        turret_turn: 0,
        fire_type: FireType::NONE }
    end
  end
end
