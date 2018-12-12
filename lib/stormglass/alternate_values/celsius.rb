class Stormglass::AlternateValues::Celsius

  def self.perform(subvalues)
    inject_fahrenheit(subvalues)
  end

  private

  def self.inject_fahrenheit(subvalues)
    subvalues << {unit_type: 'F', value: (subvalues.first[:value] * 1.8 + 32).round(2), unit: 'F', description: subvalues.first[:description], unit_description: 'degrees Fahrenheit'}
  end

end
