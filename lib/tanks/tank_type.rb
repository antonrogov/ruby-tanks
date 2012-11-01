module Tanks
  class TankType < Base
    attr_accessor :id, :width, :height, :virtual_gun_length, :mass,
                  :engine_power, :engine_rear_power_factor, :turret_turn_speed,
                  :turret_max_relative_angle, :max_health, :max_durability,
                  :frontal_armor, :side_armor, :rear_armor

    def initialize(data = {})
      super

      @@types ||= {}
      @@types[data[:id]] = self
    end

    def self.by_index(index)
      @@types[index]
    end

    MEDIUM    = new id: 0,
                    width: 90,
                    height: 60,
                    virtual_gun_length: 67.5,
                    mass: 10,
                    engine_power: 7500,
                    engine_rear_power_factor: 0.75,
                    turret_turn_speed: 1.0 * Math::PI / 180,
                    turret_max_relative_angle: 1.0 * Math::PI / 180,
                    max_health: 100,
                    max_durability: 200,
                    frontal_armor: 175,
                    side_armor: 150,
                    rear_armor: 100

    HEAVY     = new id: 0,
                    width: 105,
                    height: 75,
                    virtual_gun_length: 82.5,
                    mass: 20,
                    engine_power: 7500,
                    engine_rear_power_factor: 0.5,
                    turret_turn_speed: 0.5 * Math::PI / 180,
                    turret_max_relative_angle: 0.5 * Math::PI / 180,
                    max_health: 100,
                    max_durability: 250,
                    frontal_armor: 200,
                    side_armor: 175,
                    rear_armor: 100

    DESTROYER = new id: 2,
                    width: 112.5,
                    height: 67.5,
                    virtual_gun_length: 97.5,
                    mass: 15,
                    engine_power: 5000,
                    engine_rear_power_factor: 0.35,
                    turret_turn_speed: 1.5 * Math::PI / 180,
                    turret_max_relative_angle: 1.5 * Math::PI / 180,
                    max_health: 100,
                    max_durability: 250,
                    frontal_armor: 250,
                    side_armor: 125,
                    rear_armor: 100
  end
end
