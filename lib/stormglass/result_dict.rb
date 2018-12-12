module Stormglass

RESULT_DICT= {
  :air_temperature    =>{:unit_type => "C",     :unit=>"C",      :description=>"Air temperature as",                         :unit_description =>"degrees Celsius"},
  :air_pressure       =>{:unit_type => "hPa",   :unit=>"hPa",    :description=>"Air pressure as",                            :unit_description =>"hectopascal"},
  :cloud_cover        =>{:unit_type => "%",     :unit=>"%",      :description=>"Total cloud coverage as",                    :unit_description =>"percent"},
  :current_direction  =>{:unit_type => "Deg",   :unit=>"°",      :description=>"Direction of current",                       :unit_description =>"0° indicates coming from north"},
  :current_speed      =>{:unit_type => "Ms",    :unit=>"M/s",    :description=>"Speed of current as",                        :unit_description =>"meters per second"},
  :gust               =>{:unit_type => "Ms",    :unit=>"M/s",    :description=>"Wind gust as",                               :unit_description =>"meters per second"},
  :humidity           =>{:unit_type => "%",     :unit=>"%",      :description=>"Relative humidity as",                       :unit_description => "percent"},
  :ice_cover          =>{:unit_type => "/1",    :unit=>"/1",     :description=>"Proportion",                                 :unit_description=> "over 1"},
  :precipitation      =>{:unit_type => "Kgm2",  :unit=>"kg/m²",  :description=>"Mean precipitation as",                      :unit_description => "kilogram per square meter"},
  :sea_level          =>{:unit_type => "M",     :unit=>"M",      :description=>"Height of sea level as",                     :unit_description =>"meters"},
  :snow_depth         =>{:unit_type => "M",     :unit=>"M",      :description=>"Depth of snow as",                           :unit_description =>"meters"},
  :swell_direction    =>{:unit_type => "Deg",   :unit=>"°",      :description=>"Direction of swell waves.",                  :unit_description => "0° indicates coming from north"},
  :swell_height       =>{:unit_type => "M",     :unit=>"M",      :description=>"Height of swell waves as",                   :unit_description =>"meters"},
  :swell_period       =>{:unit_type => "Sec",   :unit=>"s",      :description=>"Period of swell waves as",                   :unit_description =>"seconds"},
  :visibility         =>{:unit_type => "Km",    :unit=>"km",     :description=>"Horizontal visibility as",                   :unit_description =>"Kilometer"},
  :water_temperature  =>{:unit_type => "C",     :unit=>"C",      :description=>"Water temperature as",                       :unit_description =>"degrees Celsius"},
  :wave_direction     =>{:unit_type => "Deg",   :unit=>"°",      :description=>"Direction of combined wind and swell waves.",:unit_description => "0° indicates coming from north"},
  :wave_height        =>{:unit_type => "M",     :unit=>"M",      :description=>"Height of combined wind and swell waves as", :unit_description =>"meters"},
  :wave_period        =>{:unit_type => "Sec",   :unit=>"s",      :description=>"Period of combined wind and swell waves as", :unit_description =>"seconds"},
  :wind_wave_direction=>{:unit_type => "Deg",   :unit=>"°",      :description=>"Direction of wind waves.",                   :unit_description => "0° indicates coming from north"},
  :wind_wave_height   =>{:unit_type => "M",     :unit=>"M",      :description=>"Height of wind waves as",                    :unit_description =>"meters"},
  :wind_wave_period   =>{:unit_type => "Sec",   :unit=>"s",      :description=>"Period of wind waves as",                    :unit_description =>"seconds"},
  :wind_direction     =>{:unit_type => "Deg",   :unit=>"°",      :description=>"Direction of wind.",                         :unit_description => "0° indicates coming from north"},
  :wind_speed         =>{:unit_type => "Ms",    :unit=>"M/s",    :description=>"Speed of wind as",                           :unit_description =>"meters per second"}
}
end
