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

  def reduce
  end

end