# Stormglass

Ruby gem for access to the [Stormglass](https://stormglass.io/) Weather forecast API.

# Overview

This gem augments the Stormglass API responses to make consuming the API more accessible for ruby developers.

- Provides weather lookup for address and lat/lng
- Provides units and descriptions for all forecast types
- Creates alternative representations of values (such as Fahrenheit, or knots)
- Specify default units and sources, or override at method invocation

For more information, visit [Stormglass API docs](https://docs.stormglass.io/)

*Note: this gem currently only implements the `point` API endpoint. Accepting pull requests!*

# Installation

```
gem install stormglass
```

or in your gemfile

```
gem 'stormglass'
```

# API Key

To use Stormglass you'll need to provide an API key, which can be configured a number of ways:

1. Enviroment variable `STORMGLASS_API_KEY`
2. within a `Stormglass.configure` block (more on that below)
3. with Rails secret `stormglass_api_key`
4. at method invocation by passing `key`

# Configuration

You can configure the gem with the following block
```
Stormglass.configure do |config|
  config.units = {air_temperature: 'F', gust: 'knot'}
  config.api_key = 'abcd-abcd-abcd'
  config.source = 'sg'
end
```

# Walkthrough

First, let's query the stormglass API for an address. This will look up via `Geocoder` and then call `Stormglass.for_lat_lng` for us with the first result.
```
response = Stormglass.for_address('123 broad street philadelphia pa', hours: 24)
=> #<Stormglass::Response remaining_requests=31, hours=[#<Stormglass::Hour time='2018-12-12 21:00:00 +0000'> ...]>
```
The methods we can call are underscored variants of what the camelCaps API returns. Taken from `stormglass/hour.rb`
```
 VALUES = [:air_temperature,:cloud_cover,:current_direction,:current_speed,:gust,:humidity,
            :precipitation,:pressure,:sea_level,:swell_direction,:swell_height,:swell_period,
            :visibility,:water_temperature,:wave_direction,:wave_height,:wave_period,
            :wind_direction,:wind_speed,:wind_wave_direction,:wind_wave_height,:wind_wave_period]
```
Let's see the first hour's air_temperature.
```
response.hours.first.air_temperature
=> #<Stormglass::Value value=44.91, unit='C', description='Air temperature as degrees Celsius', unit_type='C',
unit_types=["C", "F"], data_source='sg', data_sources=["sg", "dwd", "noaa", "wrf"]>
```
we can also call `response.first.air_temperature` or even `response.air_temperature` and it will defer to the first hour result.

But what if we don't want the first hour? In addition to calling `response.hours.select{...}`, you can use `#find` with your local timezone and it will convert to UTC for lookup
```
response.find('7AM EST').air_temperature
=> #<Stormglass::Value value=44.91, unit='C', description='Air temperature as degrees Celsius', unit_type='C',
unit_types=["C", "F"], data_source='sg', data_sources=["sg", "dwd", "noaa", "wrf"]>
```
we can work with the `response.find('7AM EST').air_temperature.value` directly, or call `to_s`

```
response.air_temperature.to_s
=> "4.91 C"
```

What if we want air temperature in Fahrenheit instead?

```
response.air_temperature(unit_type: 'F')
=> #<Stormglass::Value value=44.91, unit='F', description='Air temperature as degrees Fahrenheit', unit_type='F',
unit_types=["C", "F"], data_source='sg', data_sources=["sg", "dwd", "noaa", "wrf"]>
```

Or we can reference a different data source than the default
```
response.air_temperature(unit_type: 'F', data_source: 'noaa')
=> #<Stormglass::Value value=45.33, unit='F', description='Air temperature as degrees Fahrenheit', unit_type='F',
unit_types=["C", "F"], data_source='noaa', data_sources=["sg", "dwd", "noaa", "wrf"]>
```

# Structure

There are a few primary classes involved:
1. `Stormglass::Response` represents the result from stormglass, wrapping `hours` and `meta` responses.
Calling something like `#air_temperature` on this delegates to `#hours.first`
2. `Stormglass::Hour` represents an hour portion of the API response
3. `Stormglass::Value` represents a particular forecast value. along with the numeric `value` it also exposes
the `description` and `unit` used. It is just a wrapper to the collection of `Stormglass::Subvalue`'s and defers to the preferred/specified one.
4. `Stormglass::Subvalue` represents a particular variant of forecast value, such as `air_temperature` in Celsius or in Fahrenheit.

For any of the above instances, you can call `#src` to access the raw (usually JSON) data that was passed in to populate it.

Because each forecast type has different sources and units, `Stormglass::Value` instances exposes the progmatic
available options `data_sources` and `unit_types` you can reference for alternatives to provide.

```
response.air_temperature(unit_type: 'C')
=> #<Stormglass::Value value=7.17, unit='C', description='Air temperature as degrees Celsius', unit_type='C',
unit_types=["C", "F"], data_source='sg', data_sources=["sg", "dwd", "noaa", "wrf"]>
response.air_temperature(unit_type: 'C', data_source: 'wrf')
=> #<Stormglass::Value value=8.34, unit='C', description='Air temperature as degrees Celsius', unit_type='C',
unit_types=["C", "F"], data_source='noaa', data_sources=["sg", "dwd", "noaa", "wrf"]>
```
