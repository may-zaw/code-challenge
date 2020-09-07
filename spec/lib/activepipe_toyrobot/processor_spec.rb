# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../lib/activepipe_toyrobot/processor'
RSpec.describe ActivepipeToyrobot::Processor do
  let(:name) { 'ALICE' }
  let(:x) { 0 }
  let(:y) { 0 }
  let(:direction) { 'NORTH' }
  describe '#execute' do
    context 'valid commands' do
      before(:each) do
        @robot = described_class.execute(name, :place, "#{x},#{y},#{direction}")
      end
      after(:each) do
        @robot = nil
      end
      context 'place command' do
        it 'places the robot in the specified position and direction' do
          expect(@robot.name).to eq(name)
          expect(@robot.position).to eq({x: x, y: y})
          expect(@robot.direction).to eq(direction.downcase.to_sym)
        end
      end
      context 'move command' do
        before do
          described_class.execute(name, :move, nil)
        end
        it 'moves the robot' do
          expect(@robot.position).to eq({x: x, y: y + 1})
          expect(@robot.direction).to eq(direction.downcase.to_sym)
        end
      end
      context 'left command' do
        before do
          described_class.execute(name, :left, nil)
        end
        it 'turns 90 degree towards west' do
          expect(@robot.position).to eq({x: x, y: y})
          expect(@robot.direction).to eq(:west)
        end
      end
      context 'right command' do
        before do
          described_class.execute(name, :right, nil)
        end
        it 'turns 90 degree towards east' do
          expect(@robot.position).to eq({x: x, y: y})
          expect(@robot.direction).to eq(:east)
        end
      end
    end

    context 'invalid commands' do
      let(:robot) { nil }
      context 'first command is move' do
        before do
          robot = described_class.execute('BOB', :move, nil)
        end
        it 'does not initialize the new robot' do
          expect(robot).to eq(nil)
        end
      end
      context 'first command is left' do
        before do
          robot = described_class.execute('BOB', :left, nil)
        end
        it 'does not initialize the new robot' do
          expect(robot).to eq(nil)
        end
      end
      context 'first command is right' do
        before do
          robot = described_class.execute('BOB', :right, nil)
        end
        it 'does not initialize the new robot' do
          expect(robot).to eq(nil)
        end
      end
      context 'first command is report' do
        before do
          robot = described_class.execute('BOB', :report, nil)
        end
        it 'does not initialize the new robot' do
          expect(robot).to eq(nil)
        end
      end
    end
  end
end
