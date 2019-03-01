require_relative 'heap'
require 'ostruct'

tests = [
  OpenStruct.new(id: :test1, time: 5),
  OpenStruct.new(id: :test2, time: 10),
  OpenStruct.new(id: :test3, time: 3)
]

machines = [
  OpenStruct.new(id: 1, tests: [], time: 0),
  OpenStruct.new(id: 2, tests: [], time: 0)
]

heap = Heap.new

machines.each do |machine|
  heap.push(machine)
end

tests.each do |test|
  machine = heap.pop
  machine.tests.push(test)
  machine.time += test.time
  heap.push(machine)
end

while (machine = heap.pop) do
  puts machine.inspect
end