require 'rspec'
require File.expand_path '../../capy.rb', __FILE__

describe Capybara do

  it 'from Hydrochoerus genus' do
    expect(Capybara).to be < Hydrochoerus
  end

  subject { Capybara.new(weight: 75, height: 35, color: 'green') }

  context 'when run' do
    it 'with speed' do
      expect(subject.run('fast')).to match /I'm running fast/
    end

    it 'without speed' do
      expect { subject.run() }.to raise_error(ArgumentError)
    end
  end

  context 'when dive' do
    it 'with speed' do
      expect(subject.dive('a little')).to match /I'm diving a little/
    end

    it 'witout speed' do
      expect { subject.dive() }.to raise_error(ArgumentError)
    end
  end

  it 'is a vegan?' do
    is_expected.to be_is_vegan
  end

  it 'is a fish?' do
    is_expected.not_to be_is_fish
  end

  it 'has enemy?' do
    expect(subject.has_enemy? 'anaconda' ).to be true
  end

end