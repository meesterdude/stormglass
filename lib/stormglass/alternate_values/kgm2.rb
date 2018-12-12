class Stormglass::AlternateValues::Kgm2

  def self.perform(subvalues)
    inject_inches(subvalues)
  end

  private

  def self.inject_inches(subvalues)
    subvalues << {unit_type: 'inches', unit: 'in', value: (subvalues.first[:value] * 0.039370).round(2), description: subvalues.first[:description], unit_description: 'inches'}
  end
end
