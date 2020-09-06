require "bundler/setup"
# require "../../../lib/activepipe_toyrobot"
# ENV["RAILS_ENV"] ||= 'test'
# require File.expand_path("../../config/environment", __FILE__)
# require File.expand_path("../../config/environment", __FILE__)
# require 'rspec/rails'
# require 'rspec/autorun'
puts 'here'
RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
