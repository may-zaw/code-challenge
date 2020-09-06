#!/usr/bin/ruby
require_relative './activepipe_toyrobot/execute'

file = ARGV.first # file path

File.readlines(file).each do |line|
  data = line.gsub(/\n/, "").split(/\s* \s*/)
  robot = data[0]
  command = data[1]&.downcase.to_sym

  place_args = nil
  if (command == :place && data.length == 3)
    place_args = data[2]
  end
  ActivepipeToyrobot.execute(robot, command, place_args)
end
