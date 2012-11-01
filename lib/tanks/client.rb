module Tanks
  class Client
    module MessageType
      UNKNOWN = 0
      GAME_OVER = 1
      AUTHENTICATION_TOKEN = 2
      TEAM_SIZE = 3
      TANK_TYPES = 4
      PLAYER_CONTEXT = 5
      MOVES = 6
    end

    def connect(host, port, token)
      @stream = Stream.new host, port
      @stream.write_byte MessageType::AUTHENTICATION_TOKEN
      @stream.write_string token
    end

    def read_team_size
      read_message_type MessageType::TEAM_SIZE
      @stream.read_int
    end

    def write_selected_tank_types(types)
      @stream.write_byte MessageType::TANK_TYPES

      if types
        @stream.write_int types.size
        types.each {|type| @stream.write_byte type.id }
      else
        @stream.write_int -1
      end
    end

    def read_player_context
      read_message_type MessageType::PLAYER_CONTEXT

      read_if_present do
        PlayerContext.new tanks: read_tanks,
                          world: read_world
      end
    end

    def write_moves(moves)
      @stream.write_byte MessageType::MOVES

      if moves
        @stream.write_int moves.size
        moves.each do |move|
          if move
            @stream.write_bool true
            @stream.write_double move.left_track_power
            @stream.write_double move.right_track_power
            @stream.write_double move.turret_turn
            @stream.write_byte move.fire_type
          else
            @stream.write_bool false
          end
        end
      else
        @stream.write_int -1
      end
    end

    def disconnect
      @stream.close if @stream
    end

    private

    def read_message_type(type)
      read = @stream.read_byte
      raise "Expected message type #{type}, got #{read}" if read != type
    end

    def read_tanks
      read_array do
        Tank.new id: @stream.read_long,
                 player_name: @stream.read_string,
                 teammate_index: @stream.read_int,
                 x: @stream.read_double,
                 y: @stream.read_double,
                 speed_x: @stream.read_double,
                 speed_y: @stream.read_double,
                 angle: @stream.read_double,
                 angular_speed: @stream.read_double,
                 turret_relative_angle: @stream.read_double,
                 health: @stream.read_int,
                 durability: @stream.read_int,
                 reloading_time: @stream.read_int,
                 remaining_reloading_time: @stream.read_int,
                 premium_shell_count: @stream.read_int,
                 teammate: @stream.read_bool,
                 type: TankType.by_index(@stream.read_byte)
      end
    end

    def read_world
      read_if_present do
        World.new tick: @stream.read_int,
                  width: @stream.read_double,
                  height: @stream.read_double,
                  players: read_players,
                  obstacles: read_obstacles,
                  tanks: read_tanks,
                  shells: read_shells,
                  bonuses: read_bonuses
      end
    end

    def read_players
      read_array do
        Player.new name: @stream.read_string,
                   score: @stream.read_int,
                   strategy_crashed: @stream.read_bool
      end
    end

    def read_obstacles
      read_array do
        Obstacle.new id: @stream.read_long,
                     width: @stream.read_double,
                     height: @stream.read_double,
                     x: @stream.read_double,
                     y: @stream.read_double
      end
    end

    def read_shells
      read_array do
        Shell.new id: @stream.read_long,
                  player_name: @stream.read_string,
                  width: @stream.read_double,
                  height: @stream.read_double,
                  x: @stream.read_double,
                  y: @stream.read_double,
                  speed_x: @stream.read_double,
                  speed_y: @stream.read_double,
                  angle: @stream.read_double,
                  angular_speed: @stream.read_double,
                  type: @stream.read_byte
      end
    end

    def read_bonuses
      read_array do
        Bonus.new id: @stream.read_long,
                  width: @stream.read_double,
                  height: @stream.read_double,
                  x: @stream.read_double,
                  y: @stream.read_double,
                  type: @stream.read_byte
      end
    end

    def read_if_present(&block)
      if @stream.read_bool
        yield
      else
        nil
      end
    end

    def read_array(&block)
      size = @stream.read_int
      (1..size).map {|i| read_if_present &block }
    end
  end
end
