require './ebuberable'

describe Ebuberable do

  class MyClass

   include Ebuberable

    def initialize(*items)
      @items = items.flatten
    end

    def each(&block)
      @items.each(&block)
      self
    end

  end

  it '#map' do
    a = MyClass.new(1, 2, 3).map { |i| i*2 }

    expect(a).to eq [2, 4, 6]
  end

  it '#select' do
    a = MyClass.new(1, 2, 3, 4, 5, 6).select { |i| i > 3 }

    expect(a).to eq [4, 5, 6]
  end

  it '#reject' do
    a = MyClass.new(1, 2, 3, 4, 5, 6).reject { |i| i > 3 }

    expect(a).to eq [1, 2, 3]
  end

  it '#grep' do
    a = MyClass.new('Superman', 'Batman', 'Hulk', 'Flash').grep(/^Bat/)

    expect(a).to eq ['Batman']
  end

  it '#all?' do
    a = MyClass.new.all?

    expect(a).to eq true

    a = MyClass.new(1, 2, 3, 4, 5, 6).all? { |i| i < 7 }
    expect(a).to eq true

    a = MyClass.new(1, 2, 3, 4, 5, 6).all? { |i| i > 7 }
    expect(a).to eq false
  end

  it '#first' do
    a = MyClass.new('first', 'second', 'third').first

    expect(a).to eq 'first'
  end

  describe '#reduce' do

    it 'sum of all numbers' do
      a = MyClass.new(1, 2, 3, 4, 5).reduce(0) { |a, e| a + e }

      expect(a).to eq 15
    end

    it "return accumulator if value wasn't provided" do
      a = MyClass.new.reduce(20) { |a, e| a + e }

      expect(a).to eq 20
    end

    it 'without a block' do
      a = MyClass.new(1, 2, 3, 4, 5).reduce(0, :+)

      expect(a).to eq 15
    end

    it 'without an init value' do
      a = MyClass.new(1, 2, 3, 4, 5).reduce(:+)

      expect(a).to eq 15
    end

  end

  it '#max' do
    a = MyClass.new(1, 2, 3).max

    expect(a).to eq 3
  end

  it '#min' do
    a = MyClass.new(3, 2, 1).min

    expect(a).to eq 1
  end

end