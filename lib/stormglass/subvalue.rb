class Stormglass::Subvalue < OpenStruct

  def initialize(src)
    @src = src
    super
  end

  def to_s
    "#{@src[:value]} #{@src[:unit]}"
  end


  def description
    "#{@src[:description]} #{@src[:unit_description]}"
  end

  def src
    @src
  end

end
