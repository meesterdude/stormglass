class Stormglass::AlternateValues::Meters

  def self.perform(subvalues)
    inject_feet(subvalues)
  end

  private

  def self.inject_feet(subvalues)
    subvalues << {unit_type: 'feet', unit: 'ft', value: (subvalues.first[:value] / 0.3048).round(2), description: subvalues.first[:description], unit_description: 'feet'}
  end
end
