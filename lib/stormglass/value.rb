# represents a value for a stormglass prediction source with prefered unit_type
# contains a collection of Stormglass::Subvalue's, which represent a particular unit of measurement
# for example, a Stormglass::Value for air_temperature would have Stormglass::Subvalue's for Celsius and Fahrenheit
class Stormglass::Value
   extend Forwardable

  def_delegators :preffered_subvalue, :unit, :unit_type, :description, :unit_description


  def initialize(attribute, src, data_source, unit_type)
    @attribute = attribute
    @src = src
    @data_source = data_source
    @unit_type = unit_type
  end

  def data_source
    @data_source
  end

  def for_source
    @src.collect do |v|
      v['value'] if (!v['source'].nil? && v['source'] == data_source)
    end.compact.first
  end

  # returns the sources available for this value
  def data_sources
    src.collect{|v| v['source']}
  end

  def to_s
    preffered_subvalue.to_s
  end

  def attribute
    @attribute
  end

  def src
    @src
  end

  def inspect
    string = "#<#{self.class.to_s} "
    string +="value=#{preffered_subvalue.value}, unit='#{preffered_subvalue.unit}', description='#{preffered_subvalue.description}', "
    string +="unit_type='#{preffered_subvalue.unit_type}', unit_types=#{unit_types.to_s}, data_source='#{@data_source}', data_sources=#{data_sources}>"
    string
  end

  def unit_types
    subvalues.collect(&:unit_type)
  end

  def preffered_subvalue
    if @unit_type
      subvalues.find{|subvalue| subvalue.unit_type == @unit_type}
    elsif setting_key = Stormglass.settings.units[@attribute]
      subvalues.find{|subvalue| subvalue.unit_type == setting_key}
    else
      subvalues.first
    end
  end

  def dict
    Stormglass::RESULT_DICT[attribute]
  end

  def subvalues
    subvals = []
    raw_val = for_source()
    subvals << {value: raw_val}.merge(dict)
    Stormglass::AlternateValues.perform(subvals)
    subvals.collect{|subvalue| Stormglass::Subvalue.new(subvalue) }
  end


end
