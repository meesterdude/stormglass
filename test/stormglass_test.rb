require "test_helper"

class StormglassTest < Minitest::Test

  def test_that_it_has_a_version_number
    refute_nil ::Stormglass::VERSION
  end

  def test_api_key_present
    assert Stormglass.api_key.length > 15
  end

  def test_for_address
    response = Stormglass.for_address("bala cynwyd 19004")
    assert response.hours.size > 10
    assert !response.air_temperature.nil?
  end

  def test_hours_returned
    response = Stormglass.for_address("bala cynwyd 19004", hours: 24)
    assert response.hours.size >= 24
  end

  def test_finding_hours
    response = Stormglass.for_address("bala cynwyd 19004", start: DateTime.parse("today 7AM"), hours: 3)
    assert response.find('today 9AM UTC') == response.hours[1]
  end

  def test_for_lat_lng
    response = Stormglass.for_lat_lng(lat: 38.8977, lng: 77.0365 )
    assert response.hours.size > 10
    assert !response.air_temperature.nil?
  end

  def test_subvalues_available
    response = Stormglass.for_lat_lng(lat: 38.8977, lng: 77.0365 )
    assert response.gust.unit_types == ["Ms", "knot", "MPH"]
    assert response.air_temperature.unit_types == ["C", "F"]
  end

  def test_method_params
    response = Stormglass.for_lat_lng(lat: 38.8977, lng: 77.0365 )
    assert response.gust.unit_type == "Ms"
    assert response.gust(unit_type: 'knot').unit_type == "knot"
    assert response.gust(data_source: 'noaa').data_source == "noaa"
  end
end
