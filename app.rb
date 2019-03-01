require_relative 'heap'
require 'ostruct'

class CITool
  def initialize
    @tests = [
      OpenStruct.new(id: :test1, time: 5),
      OpenStruct.new(id: :test2, time: 10),
      OpenStruct.new(id: :test3, time: 3),
      OpenStruct.new(id: :test4, time: 1),
      OpenStruct.new(id: :test5, time: 100)
    ]
  end

  def allocate_tests_to_machines(test_ids, machines)
    heap = Heap.new

    machines.each do |machine|
      heap.push(machine)
    end

    tests = @tests
      .select { |test| test_ids.include?(test.id) }
      .sort { |a, b| b.time <=> a.time }

    tests.each do |test|
      machine = heap.pop
      machine.tests.push(test)
      machine.time += test.time
      heap.push(machine)
    end

    heap
  end
end

machines = [
  OpenStruct.new(id: 1, tests: [], time: 0),
  OpenStruct.new(id: 2, tests: [], time: 0)
]

tool = CITool.new
heap = tool.allocate_tests_to_machines([:test1, :test5], machines)

while (machine = heap.pop) do
  puts machine.inspect
end
