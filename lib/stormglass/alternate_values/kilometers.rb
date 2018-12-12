class Stormglass::AlternateValues::Kilometers

  def self.perform(subvalues)
    inject_miles(subvalues)
  end

  private

  def self.inject_miles(subvalues)
    subvalues << {unit_type: 'miles', unit: 'mi', value: (subvalues.first[:value] / 1.609344).round(2), description: subvalues.first[:description], unit_description: 'miles'}
  end
end
