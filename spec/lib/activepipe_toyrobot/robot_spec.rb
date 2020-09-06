# frozen_string_literal: true
require 'spec_helper'
require_relative '../../../lib/activepipe_toyrobot/robot'

RSpec.describe ActivepipeToyrobot::Robot do
  let(:name) { 'ALICE' }
  let(:x) { 0 }
  let(:y) { 0 }
  let(:direction) { 'NORTH' }
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
    let(:current_position) { @robot.position }
    let(:current_direction) { @robot.direction }
    context 'invalid coordinates' do
      it 'does not move' do
        expect(@robot.place('a', 'b', :south)).to be_falsey
        expect(@robot.direction).to eq(current_direction)
        expect(@robot.position).to eq(current_position)
      end
    end
    context 'invalid direction' do
      it 'does not move' do
        expect(@robot.place(0, 0, :northeast)).to be_falsey
        expect(@robot.direction).to eq(current_direction)
        expect(@robot.position).to eq(current_position)
      end
    end
    context 'invalid position outside of the range' do
      it 'does not move' do
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
    let(:current_direction) { @robot.direction }
    let(:current_position) { @robot.position }
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
      end
    end
    context 'current direction is east' do
      before do
        @robot.direction = :east
        @robot.move
      end
      it 'moves one step east' do
        expect(@robot.position).to eq({ x: 2, y: 1})
      end
    end
    context 'current direction is south' do
      before do
        @robot.direction = :south
        @robot.move
      end
      it 'moves one step south' do
        expect(@robot.position).to eq({ x: 1, y: 0})
      end
    end
    context 'current direction is west' do
      before do
        @robot.direction = :west
        @robot.move
      end
      it 'moves one step west' do
        expect(@robot.position).to eq({ x: 0, y: 1})
      end
    end
  end
end
