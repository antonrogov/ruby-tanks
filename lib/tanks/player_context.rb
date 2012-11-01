module Tanks
  class PlayerContext < Base
    attr_accessor :tanks, :world

    def valid?(size)
      @tanks && @world && @tanks.size == size
    end
  end
end
