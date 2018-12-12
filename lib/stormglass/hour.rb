# represents an hour result from Stormglass
# VALUES represent callable methods
class Stormglass::Hour

  VALUES = [:air_temperature,:cloud_cover,:current_direction,:current_speed,:gust,:humidity,
            :precipitation,:pressure,:sea_level,:swell_direction,:swell_height,:swell_period,
            :visibility,:water_temperature,:wave_direction,:wave_height,:wave_period,
            :wind_direction,:wind_speed,:wind_wave_direction,:wind_wave_height,:wind_wave_period]

  def initialize(src)
    @src = src
  end

  def src
    @src
  end

  def time
    Time.parse(src["time"])
  end

  def values
    src.keys.collect(&:underscore)
  end

  def method_missing(method, *args)
    if VALUES.include?(method)
      get_value(method, args)
    else
      super
    end
  end

  def respond_to_missing?(method_name, include_private = false)
    VALUES.include?(method_name) || super
  end

  def inspect
    string = "#<#{self.class.to_s} time='#{time}'> "
  end

  # handler for each VALUES method (such as air_temperature)
  # takes two optional arguments:
  # data_source: - data source to use. (default 'sg')
  # unit_type:   - preferred unit type (default API result)
  def get_value(attribute,args)
    vals = fetch_value(args.first ? {attribute: attribute}.merge(args.first) : {attribute: attribute})
    @src.keys.collect(&:underscore).zip(vals).to_h[attribute.to_s]
  end

  def fetch_value(data_source: nil, attribute:, unit_type: nil)
    data_source ||= Stormglass.settings.source
    @src.values.collect do |val|
      if val.is_a?(String)
        val
      else
        Stormglass::Value.new(attribute, val, data_source, unit_type)
      end
    end
  end
end
