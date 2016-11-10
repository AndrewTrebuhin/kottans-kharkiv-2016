class Hydrochoerus
end

class Capybara < Hydrochoerus

  attr_accessor :weight, :height, :color

  def initialize(params = {})
    @weight = params[:weight]
    @height = params[:weight]
    @color  = params[:color]
  end

  def run(speed)
    "I'm running #{speed}"
  end

  def dive(deep)
    "I'm diving #{deep}"
  end

  def is_vegan?
    true
  end

  def is_fish?
    puts "No! Only Pope of Rome thought that!"
    false
  end

  def has_enemy?(someone)
    ['anaconda', 'aligator', 'jaguar'].include?(someone.to_s.downcase)
  end

end