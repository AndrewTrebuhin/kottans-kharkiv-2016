class Object

  def try (*args, &block)
    if args.empty? && block_given?
      yield self
    elsif args.first != nil
      send(*args, &block) if respond_to?(args.first)
    else
      nil
    end
  end
end