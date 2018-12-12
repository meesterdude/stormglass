class Stormglass::AlternateValues::Degrees

  POINTS = ['N', 'NNE', 'NE', 'ENE', 'E', 'ESE', 'SE', 'SSE', 'S', 'SSW', 'SW', 'WSW', 'W', 'WNW', 'NW', 'NNW']

  def self.perform(subvalues)
    inject_compass_points(subvalues)
  end

  private

  def self.inject_compass_points(subvalues)
    compass_point = Geocoder::Calculations.compass_point(subvalues.first[:value], POINTS)
    subvalues << {unit_type: 'compass', value: compass_point, unit: '', description: subvalues.first[:description], unit_description: 'From 16 shorthand compass points'}
  end

end
