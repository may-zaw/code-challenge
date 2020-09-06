require_relative "./validation"

module ActivepipeToyrobot
  class Robot
    @@robots = []

    attr_accessor :name, :position, :direction
    DIRECTIONS = %i[north east south west]

    def initialize(name, x, y, direction)
      @name = name
      @position = { x: x, y: y }
      @direction = direction
      @@robots << self
    end

    def self.all
      @@robots
    end

    def place(x, y, direction)
      return false unless ActivepipeToyrobot::Validation.valid_coordinates?(x, y)
      return false unless ActivepipeToyrobot::Validation.valid_direction?(direction)

      if ActivepipeToyrobot::Validation.on_the_board?(x, y)
        @position = { x: x, y: y }
        @direction = direction
      end
    end

    def move
      return false if @position.nil?
      position = @position
      movement = nil

      case @direction
        when :north
          movement = { x: 0, y: 1}
        when :east
          movement = { x: 1, y: 0}
        when :south
          movement = { x: 0, y: -1}
        when :west
          movement = { x: -1, y: 0}
        end

      new_x_position=position[:x] + movement[:x]
      new_y_position=position[:y] + movement[:y]
      if ActivepipeToyrobot::Validation.on_the_board?(new_x_position, new_y_position) && ActivepipeToyrobot::Validation.possible_collision?(new_x_position, new_y_position)
        @position = { x: new_x_position, y: new_y_position }
      end
    end

    def turn_left
      return false if @direction.nil?

      index = DIRECTIONS.index(@direction)
      @direction = DIRECTIONS.rotate(-1)[index]
    end

    def turn_right
      return false if @direction.nil?

      index = DIRECTIONS.index(@direction)
      @direction = DIRECTIONS.rotate()[index]
    end

    def report
      return false if @position.nil? or @direction.nil?
      puts "#{@name} #{@position[:x]},#{@position[:y]},#{@direction.to_s.upcase}"
    end
  end
end
