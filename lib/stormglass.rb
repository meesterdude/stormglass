require "stormglass/version"
require 'restclient'
require 'date'
require 'json'
require 'forwardable'
require 'geocoder'
require 'stormglass/configuration'
require 'stormglass/hour'
require 'stormglass/response'
require 'stormglass/string'
require 'stormglass/result_dict'
require 'stormglass/value'
require 'stormglass/subvalue'
require 'stormglass/alternate_values'

Dir[File.join(__dir__, 'stormglass', 'alternate_values', '*.rb')].each { |file| require file }


module Stormglass
  class Error < StandardError; end
  class ConnectionError < StandardError; end
  class ExceededLimitError < StandardError; end


  class << self
    attr_accessor :settings

    def configure
      self.settings ||= Configuration.new
      yield(settings)
    end

    def set_settings
      self.settings = Configuration.new
    end
  end

  # lookup an address (such as city + zip) and get the coordinates for the first match
  def self.for_address(address_string, params={})
    if results = Geocoder.search(address_string)
      lat,lng = results.first.coordinates
      self.for_lat_lng(lat: lat, lng: lng, params: params)
    else
      raise Error, 'Could not find address'
    end
  end

  # query StormGlass given lat/lng.
  # params:
  #  :lat - dateTime (default Now)
  #  :lng - Datetime (default 12 hours from :start)
  #  :params - additional params available to self.reqest
  def self.for_lat_lng(lat:, lng:, params: {})
    self.request(params: {lat: lat, lng: lng}.merge(params))
  end

  # Primary interface to StormGlass.
  # params:
  #  :start - dateTime (default Now)
  #  :end - Datetime (default 12 hours from :start)
  #  :hours - number of hours to determine end (default 12)
  #  :key - API key (default to api_key method )
  def self.request(endpoint: 'point', params: {})
    hours = (params.delete(:hours) || 11) - 1
    params[:key] ||= api_key
    params[:start] ||= DateTime.now
    params[:end] ||= hours_offset(params[:start], hours)
    params[:start] = query_time_string(params[:start])
    params[:end] = query_time_string(params[:end])
    key = params.delete(:key)
    begin
      body = RestClient.get("https://api.stormglass.io/#{endpoint}", {params: params,  'Authorization' => key}).body
    rescue SocketError => msg
      puts msg
      raise ConnectionError, 'error connecting to stormglass'
    rescue RestClient::PaymentRequired => msg
      puts msg
      raise ExceededLimitError, 'exceeded limit. payment required for additional daily requests'
    end
    Stormglass::Response.new(body)
  end

  # API key for stormglass. key is sourced:
  # - if set via enviroment variable
  # - if set in configuration block
  # - if defined in Rails secrets
  # - when passed directly to parameters
  def self.api_key
    key = Stormglass.settings.api_key
    key ||= Rails.application.credentials[:stormglass_api_key] if Gem.loaded_specs.has_key?('rails')
    key
  end

  def self.hours_offset(start_time, hours=12)
    (start_time + (Rational(1,24) * hours))
  end

  def self.query_time_string(datetime)
    datetime.new_offset(0).iso8601
  end

end
Stormglass.set_settings
