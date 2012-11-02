require 'socket'
require_relative 'tanks/base'
require_relative 'tanks/position'
require_relative 'tanks/unit'
require_relative 'tanks/bonus'
require_relative 'tanks/move'
require_relative 'tanks/player'
require_relative 'tanks/player_context'
require_relative 'tanks/shell'
require_relative 'tanks/tank'
require_relative 'tanks/tank_type'
require_relative 'tanks/team'
require_relative 'tanks/world'
require_relative 'tanks/stream'
require_relative 'tanks/client'

module Tanks
  def self.run(strategy_class, host = nil, port = nil, token = nil)
    host ||= 'localhost'
    port = (port || 31000).to_i
    token ||= '0000000000000000'

    client = Client.new
    client.connect host, port, token

    team = Team.new client.read_team_size, strategy_class
    client.write_selected_tank_types team.tank_types

    loop do
      context = client.read_player_context
      break unless context && context.valid?(team.size)

      client.write_moves team.move(context)
    end
  rescue
    client.disconnect if client
    raise
  end
end
