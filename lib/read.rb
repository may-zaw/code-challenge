#!/usr/bin/ruby
require_relative './activepipe_toyrobot/processor'

file = ARGV.first # file path

File.readlines(file).each do |line|
  # for the freedom of robot name, there are 2 splits
  data = line.gsub(/\n/, "").split(/\s*:\s*/)
  robot = data[0]
  command_data = data[1].split(/\s* \s*/)
  command = command_data[0]&.downcase.to_sym

  place_args = nil
  if (command == :place && command_data.length == 2)
    place_args = command_data[1]
  end
  ActivepipeToyrobot::Processor.execute(robot, command, place_args)
end
