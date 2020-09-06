module ActivepipeToyrobot
  class Validation
    COMMANDS = %i[place move left right report]
    DIRECTIONS = %i[north east south west]
    X_RANGE = Y_RANGE = Range.new(0, 6)

    def self.on_the_board?(x, y)
      (X_RANGE).member?(x) && (Y_RANGE).member?(y)
    end

    def self.possible_collision?(x, y)
      ActivepipeToyrobot::Robot.all.map do |robot|
        if robot.position == { x: x, y: y }
          return false
        end
      end
      true
    end

    def self.valid_coordinates?(x, y)
      x.is_a? Integer and y.is_a? Integer
    end

    def self.valid_direction?(direction)
      DIRECTIONS.include?(direction)
    end
  end
end
