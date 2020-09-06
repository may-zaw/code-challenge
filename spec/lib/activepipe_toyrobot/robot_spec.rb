# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../lib/activepipe_toyrobot/robot'

RSpec.describe ActivepipeToyrobot::Robot do
  let(:name) { 'ALICE' }
  let(:x) { 0 }
  let(:y) { 0 }
  let(:direction) { 'NORTH' }
  let(:current_direction) { @robot.direction }
  let(:current_position) { @robot.position }
  before do
    described_class.class_variable_set(:@@robots, [])
    @robot = described_class.new(name, x, y, direction)
  end
  describe '#initialize' do
    context 'creating and placing a new robot' do
      it 'creates the robot and places at the specified position and direction' do
        expect(@robot.name).to eq(name)
        expect(@robot.position).to eq({x: x, y: y})
        expect(@robot.direction).to eq(direction)
      end
    end
  end

  describe '#all' do
    context 'all instances' do
      it 'stores the instance of the robot class' do
        expect(described_class.class_variable_get(:@@robots)).to eq([@robot])
      end
    end
  end

  describe '#place' do
    context 'invalid coordinates' do
      it 'ignores move' do
        expect(@robot.place('a', 'b', :south)).to be_falsey
        expect(@robot.direction).to eq(current_direction)
        expect(@robot.position).to eq(current_position)
      end
    end
    context 'invalid direction' do
      it 'ignores move' do
        expect(@robot.place(0, 0, :northeast)).to be_falsey
        expect(@robot.direction).to eq(current_direction)
        expect(@robot.position).to eq(current_position)
      end
    end
    context 'invalid position outside of the range' do
      it 'ignores move' do
        expect(@robot.place(7, 0, :north)).to be_falsey
        expect(@robot.direction).to eq(current_direction)
        expect(@robot.position).to eq(current_position)
      end
    end
    context 'valid coordinates and direction' do
      before do
        @robot.place(1, 1, :south)
      end
      it 'places the robot' do
        expect(@robot.direction).to eq(:south)
        expect(@robot.position).to eq({:x => 1, :y => 1})
      end
    end
  end

  describe '#move' do
    before do
      @robot.position = { x: 1, y: 1}
    end
    context 'null position' do
      before do
        @robot.position = nil
        @robot.move
      end
      it 'ignores move' do
        expect(@robot.position).to eq(current_position)
      end
    end
    context 'moving out of the board' do
      before do
        @robot.position = {x: 6, y:6}
        @robot.direction = :east
        @robot.move
      end
      it 'ignores move' do
        expect(@robot.position).to eq(current_position)
      end
    end
    context 'another robot in the next location' do
      before do
        @robot2 = described_class.new('BOB', 1, 2, :west)
        @robot.position = {x: 1, y: 1}
        @robot.direction = :east
        @robot.move
      end
      it 'ignores move' do
        expect(@robot.position).to eq(current_position)
      end
    end
    context 'current direction is north' do
      before do
        @robot.direction = :north
        @robot.move
      end
      it 'moves one step north' do
        expect(@robot.position).to eq({ x: 1, y: 2})
        expect(@robot.direction).to eq(current_direction)
      end
    end
    context 'current direction is east' do
      before do
        @robot.direction = :east
        @robot.move
      end
      it 'moves one step east' do
        expect(@robot.position).to eq({ x: 2, y: 1})
        expect(@robot.direction).to eq(current_direction)
      end
    end
    context 'current direction is south' do
      before do
        @robot.direction = :south
        @robot.move
      end
      it 'moves one step south' do
        expect(@robot.position).to eq({ x: 1, y: 0})
        expect(@robot.direction).to eq(current_direction)
      end
    end
    context 'current direction is west' do
      before do
        @robot.direction = :west
        @robot.move
      end
      it 'moves one step west' do
        expect(@robot.position).to eq({ x: 0, y: 1})
        expect(@robot.direction).to eq(current_direction)
      end
    end
  end
  describe '#turn_left' do
    context 'current direction is empty' do
      before do
        @robot.direction = nil
        @robot.turn_left
      end
      it 'ignores move' do
        expect(@robot.position).to eq(current_position)
      end
    end
    context 'current direction is north' do
      before do
        @robot.direction = :north
        @robot.turn_left
      end
      it 'turns 90 degree towards west without changing the position' do
        expect(@robot.position).to eq(current_position)
        expect(@robot.direction).to eq(:west)
      end
    end
    context 'current direction is east' do
      before do
        @robot.direction = :east
        @robot.turn_left
      end
      it 'turns 90 degree towards north without changing the position' do
        expect(@robot.position).to eq(current_position)
        expect(@robot.direction).to eq(:north)
      end
    end
    context 'current direction is south' do
      before do
        @robot.direction = :south
        @robot.turn_left
      end
      it 'turns 90 degree towards east without changing the position' do
        expect(@robot.position).to eq(current_position)
        expect(@robot.direction).to eq(:east)
      end
    end
    context 'current direction is west' do
      before do
        @robot.direction = :west
        @robot.turn_left
      end
      it 'turns 90 degree towards south without changing the position' do
        expect(@robot.position).to eq(current_position)
        expect(@robot.direction).to eq(:south)
      end
    end
  end
  describe '#turn_right' do
    context 'current direction is empty' do
      before do
        @robot.direction = nil
        @robot.turn_right
      end
      it 'ignores move' do
        expect(@robot.position).to eq(current_position)
      end
    end
    context 'current direction is north' do
      before do
        @robot.direction = :north
        @robot.turn_right
      end
      it 'turns 90 degree towards east without changing the position' do
        expect(@robot.position).to eq(current_position)
        expect(@robot.direction).to eq(:east)
      end
    end
    context 'current direction is east' do
      before do
        @robot.direction = :east
        @robot.turn_right
      end
      it 'turns 90 degree towards south without changing the position' do
        expect(@robot.position).to eq(current_position)
        expect(@robot.direction).to eq(:south)
      end
    end
    context 'current direction is south' do
      before do
        @robot.direction = :south
        @robot.turn_right
      end
      it 'turns 90 degree towards west without changing the position' do
        expect(@robot.position).to eq(current_position)
        expect(@robot.direction).to eq(:west)
      end
    end
    context 'current direction is west' do
      before do
        @robot.direction = :west
        @robot.turn_right
      end
      it 'turns 90 degree towards north without changing the position' do
        expect(@robot.position).to eq(current_position)
        expect(@robot.direction).to eq(:north)
      end
    end
  end
  describe '#report' do
    context 'current position is empty' do
      before do
        @robot.position = nil
        @robot.report
      end
      it 'does not output' do
        expect do
          @robot.report
        end.to_not output("#{name} #{x},#{y},#{direction.upcase}\n").to_stdout
      end
    end
    context 'current direction is empty' do
      before do
        @robot.direction = nil
        @robot.report
      end
      it 'does not output' do
        expect do
          @robot.report
        end.to_not output("#{name} #{x},#{y},#{direction.upcase}\n").to_stdout
      end
    end
    context 'valid current position' do
      it 'reports the current position and direction' do
        expect do
          @robot.report
        end.to output("#{name} #{x},#{y},#{direction.upcase}\n").to_stdout
      end
    end
  end
end
