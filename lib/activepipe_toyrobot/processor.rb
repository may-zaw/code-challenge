require_relative "./robot"

module ActivepipeToyrobot
  class Processor
    def self.execute(robot, command, place_args)
      current_robot = nil

      ActivepipeToyrobot::Robot.all.map do |tr|
        current_robot = tr if tr.name == robot
      end
      return nil if current_robot.nil? && command != :place

      case command
      when :place
        coordinates = place_args.split(/,/)
        puts("Invalid place arguments for #{robot}") if coordinates.count != 3

        x = coordinates[0].to_i
        y = coordinates[1].to_i
        direction = coordinates[2].downcase.to_sym

        current_robot = current_robot.nil? ? ActivepipeToyrobot::Robot.new(robot,x,y,direction) : current_robot.place(x, y, direction)

      when :move
        current_robot.move
      when :left
        current_robot.turn_left
      when :right
        current_robot.turn_right
      when :report
        current_robot.report
      else
        puts "Invalid command name"
      end
      current_robot
    end
  end
end
