module Ebuberable

  def map(&block)
    result = []
    self.each do |element|
      result << block.call(element)
    end
    result
  end

  def select(&block)
    result = []
    self.each do |element|
      result << element if block.call(element)
    end
    result
  end

  def reject(&block)
    result = []
    self.each do |element|
      result << element unless block.call(element)
    end
    result
  end

  def grep(pattern)
    result = []
    self.each do |element|
      result << element if pattern === element
    end
    result
  end

  def all?(&block)
    block ||= proc {|element| element}
    self.each do |element|
      return false unless block.call(element)
    end
    true
  end

  def first
    found = nil
    self.each do |element|
      found = element
      break
    end
    found
  end

def reduce(accumulator = nil, operation = nil, &block)
  if accumulator.nil? && operation.nil? && block.nil?
    raise ArgumentError, "you must provide an operation or a block"
  end

  if operation && block
    raise ArgumentError, "you must provide either an operation symbol or a block, not both"
  end

  if operation.nil? && block.nil?
    operation = accumulator
    accumulator = nil
  end

  block = case operation
    when Symbol
      lambda { |acc, value| acc.send(operation, value) }
    when nil
      block
    else
    raise ArgumentError, "the operation provided must be a symbol"
  end

  if accumulator.nil?
    ignore_first = true
    accumulator = first
  end

  index = 0

  each do |element|
    unless ignore_first && index == 0
      accumulator = block.call(accumulator, element)
    end
    index += 1
  end
  accumulator
end

end