class Stormglass::AlternateValues::MetersSec

  def self.perform(subvalues)
    inject_knots(subvalues)
    inject_mph(subvalues)
  end

  private

  def self.inject_knots(subvalues)
    subvalues << {unit_type: 'knot', unit: 'Kn', value: (subvalues.first[:value] * 1.9438445).round(2), description: subvalues.first[:description], unit_description: 'nautical knots'}
  end

  def self.inject_mph(subvalues)
    subvalues << {unit_type: 'MPH', unit: 'MPH', value: (subvalues.first[:value] * 2.236936).round(2), description: subvalues.first[:description], unit_description: 'miles per hour'}
  end
end
