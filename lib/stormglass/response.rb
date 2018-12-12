# Responses from Stormglass API are wrapped in this class
class Stormglass::Response
  extend Forwardable

  # convenience delegate calls (like air_temperature)
  # to the first hour returned
  def_delegators :first, *Stormglass::Hour::VALUES


  def initialize(src)
    @src = JSON.parse(src)
  end

  # an array of Stormglass::Hour instances
  def hours
    @hours ||= []
    return @hours if !@hours.empty?
    src['hours'].each{|h| @hours << Stormglass::Hour.new(h) }
    @hours
  end

  def src
    @src
  end

  def inspect
    string = '#<' + "#{self.class.to_s} remaining_requests=#{remaining_requests}, "
    string +="hours=#{hours.to_s}> "
    string
  end

  def first
    hours.first
  end

  def last
    hours.last
  end

  # takes a string like "7PM EST" and returns the relevant hour if found
  def find(string)
    hours.find{|h| h.time == Time.parse(string)}
  end

  def meta
    src['meta']
  end

  def remaining_requests
     meta['dailyQuota'] - meta['requestCount']
  end
end
