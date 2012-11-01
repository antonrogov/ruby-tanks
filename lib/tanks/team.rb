module Tanks
  class Team
    class Member
      def initialize(strategy)
        @strategy = strategy
      end

      def tank_type
        @tank_type ||= @strategy.select_tank_type
      end

      def move(context)
        @strategy.move context.tanks[@strategy.index], context.world
      end
    end

    def initialize(size, strategy_class)
      @members = (1..size).to_a.map {|i|
        Member.new strategy_class.new(i, size)
      }
    end

    def tank_types
      @members.map {|p| p.tank_type }
    end

    def move(context)
      @members.map {|p| p.move context }
    end

    def size
      @members.size
    end
  end
end
