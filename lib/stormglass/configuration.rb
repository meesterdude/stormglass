class Configuration
  attr_accessor :units, :api_key, :source

  def initialize
    @units = {}
    @api_key = ENV['STORMGLASS_API_KEY']
    @source = 'sg'
  end
end
