class Stormglass::AlternateValues

  def self.perform(subvalues)
    @original = subvalues.first
    case subvalues.first[:unit_type]
      when "Ms" then self::MetersSec.perform(subvalues)
      when "M"  then self::Meters.perform(subvalues)
      when "C" then self::Celsius.perform(subvalues)
      when "Km" then self::Kilometers.perform(subvalues)
      when 'Kgm2' then self::Kgm2.perform(subvalues)
      when 'Deg' then self::Degrees.perform(subvalues)
    end
  end

  def self.meters_sec(subvalues)

  end

  def self.meters(subvalues)

  end

  def self.c(subvalues)

  end

  def self.km(subvalues)

  end


end
