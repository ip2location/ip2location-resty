# IP2Location OpenResty Package

This OpenResty package provides a fast lookup of country, region, city, latitude, longitude, ZIP code, time zone, ISP, domain name, connection type, IDD code, area code, weather station code, station name, mcc, mnc, mobile brand, elevation, usage type, address type and IAB category from IP address by using IP2Location database. This package uses a file based database available at IP2Location.com. This database simply contains IP blocks as keys, and other information such as country, region, city, latitude, longitude, ZIP code, time zone, ISP, domain name, connection type, IDD code, area code, weather station code, station name, mcc, mnc, mobile brand, elevation, usage type, address type and IAB category as values. It supports both IP address in IPv4 and IPv6.

This package can be used in many types of projects such as:

 - select the geographically closest mirror
 - analyze your web server logs to determine the countries of your visitors
 - credit card fraud detection
 - software export controls
 - display native language and currency 
 - prevent password sharing and abuse of service 
 - geotargeting in advertisement

The database will be updated on a monthly basis for greater accuracy. Free LITE databases are available at https://lite.ip2location.com/ upon registration.

The paid databases are available at https://www.ip2location.com under Premium subscription package.

As an alternative, this package can also call the IP2Location Web Service. This requires an API key. If you don't have an existing API key, you can subscribe for one at the below:

https://www.ip2location.com/web-service/ip2location

## Installation

```
opm get ip2location/ip2location-resty
```

## QUERY USING THE BIN FILE

## Dependencies

This package requires IP2Location BIN data file to function. You may download the BIN data file at
* IP2Location LITE BIN Data (Free): https://lite.ip2location.com
* IP2Location Commercial BIN Data (Comprehensive): https://www.ip2location.com


## IPv4 BIN vs IPv6 BIN

Use the IPv4 BIN file if you just need to query IPv4 addresses.

Use the IPv6 BIN file if you need to query BOTH IPv4 and IPv6 addresses.


## Methods

Below are the methods supported in this package.

|Method Name|Description|
|---|---|
|get_all|Returns the geolocation information in an object.|
|get_country_short|Returns the country code.|
|get_country_long|Returns the country name.|
|get_region|Returns the region name.|
|get_city|Returns the city name.|
|get_isp|Returns the ISP name.|
|get_latitude|Returns the latitude.|
|get_longitude|Returns the longitude.|
|get_domain|Returns the domain name.|
|get_zipcode|Returns the ZIP code.|
|get_timezone|Returns the time zone.|
|get_netspeed|Returns the net speed.|
|get_iddcode|Returns the IDD code.|
|get_areacode|Returns the area code.|
|get_weatherstationcode|Returns the weather station code.|
|get_weatherstationname|Returns the weather station name.|
|get_mcc|Returns the mobile country code.|
|get_mnc|Returns the mobile network code.|
|get_mobilebrand|Returns the mobile brand.|
|get_elevation|Returns the elevation in meters.|
|get_usagetype|Returns the usage type.|
|get_addresstype|Returns the address type.|
|get_category|Returns the IAB category.|
|close|Closes BIN file and resets metadata.|

## Usage

```Nginx
worker_processes  1;
error_log logs/error.log;
events {
    worker_connections 1024;
}
http {
    server {
        listen 8080 reuseport;
        location / {
            default_type text/html;
            content_by_lua_block {
                local ip2location = require('ip2location')
                local ip2loc = ip2location:new('/usr/local/ip2location/IP-COUNTRY-REGION-CITY-LATITUDE-LONGITUDE-ZIPCODE-TIMEZONE-ISP-DOMAIN-NETSPEED-AREACODE-WEATHER-MOBILE-ELEVATION-USAGETYPE-ADDRESSTYPE-CATEGORY.BIN')
                local result = ip2loc:get_all('8.8.8.8')
                ngx.say("country_short: " .. result.country_short)
                ngx.say("country_long: " .. result.country_long)
                ngx.say("region: " .. result.region)
                ngx.say("city: " .. result.city)
                ngx.say("isp: " .. result.isp)
                ngx.say("latitude: " .. result.latitude)
                ngx.say("longitude: " .. result.longitude)
                ngx.say("domain: " .. result.domain)
                ngx.say("zipcode: " .. result.zipcode)
                ngx.say("timezone: " .. result.timezone)
                ngx.say("netspeed: " .. result.netspeed)
                ngx.say("iddcode: " .. result.iddcode)
                ngx.say("areacode: " .. result.areacode)
                ngx.say("weatherstationcode: " .. result.weatherstationcode)
                ngx.say("weatherstationname: " .. result.weatherstationname)
                ngx.say("mcc: " .. result.mcc)
                ngx.say("mnc: " .. result.mnc)
                ngx.say("mobilebrand: " .. result.mobilebrand)
                ngx.say("elevation: " .. result.elevation)
                ngx.say("usagetype: " .. result.usagetype)
                ngx.say("addresstype: " .. result.addresstype)
                ngx.say("category: " .. result.category)
                ip2loc:close()
            }
        }
    }
}
```

## QUERY USING THE IP2LOCATION WEB SERVICE

## Methods
Below are the methods supported in this package.

|Method Name|Description|
|---|---|
|open| 3 input parameters:<ol><li>IP2Location API Key.</li><li>Package (WS1 - WS25)</li></li><li>Use HTTPS or HTTP</li></ol> |
|lookup|Query IP address. This method returns an object containing the geolocation info. <ul><li>country_code</li><li>country_name</li><li>region_name</li><li>city_name</li><li>latitude</li><li>longitude</li><li>zip_code</li><li>time_zone</li><li>isp</li><li>domain</li><li>net_speed</li><li>idd_code</li><li>area_code</li><li>weather_station_code</li><li>weather_station_name</li><li>mcc</li><li>mnc</li><li>mobile_brand</li><li>elevation</li><li>usage_type</li><li>address_type</li><li>category</li><li>continent<ul><li>name</li><li>code</li><li>hemisphere</li><li>translations</li></ul></li><li>country<ul><li>name</li><li>alpha3_code</li><li>numeric_code</li><li>demonym</li><li>flag</li><li>capital</li><li>total_area</li><li>population</li><li>currency<ul><li>code</li><li>name</li><li>symbol</li></ul></li><li>language<ul><li>code</li><li>name</li></ul></li><li>idd_code</li><li>tld</li><li>is_eu</li><li>translations</li></ul></li><li>region<ul><li>name</li><li>code</li><li>translations</li></ul></li><li>city<ul><li>name</li><li>translations</li></ul></li><li>geotargeting<ul><li>metro</li></ul></li><li>country_groupings</li><li>time_zone_info<ul><li>olson</li><li>current_time</li><li>gmt_offset</li><li>is_dst</li><li>sunrise</li><li>sunset</li></ul></li><ul>|
|get_credit|This method returns the web service credit balance in an object.|

## Usage

```Nginx
worker_processes  1;
error_log logs/error.log;
events {
    worker_connections 1024;
}
http {
    resolver 8.8.8.8;
    server {
        listen 8080 reuseport;
        location / {
            default_type text/html;
            content_by_lua_block {
                local ip2locationwebservice = require('ip2locationwebservice')
                local apikey = 'YOUR_API_KEY'
                local apipackage = 'WS25'
                local usessl = true
                local lang = 'fr' -- leave blank if no need
                local addon = 'continent,country,region,city,geotargeting,country_groupings,time_zone_info' -- leave blank if no need

                local ip = '8.8.8.8'
                local ws = ip2locationwebservice:open(apikey, apipackage, usessl)
                local result = ws:lookup(ip, addon, lang)

                if result["response"] == nil then
                    ngx.say("Error: Unknown error.")
                elseif result.response == "OK" then
                    -- standard results
                    ngx.say("response: " .. result.response)
                    ngx.say("country_code: " .. result.country_code)
                    ngx.say("country_name: " .. result.country_name)
                    ngx.say("region_name: " .. result.region_name)
                    ngx.say("city_name: " .. result.city_name)
                    ngx.say("latitude: " .. result.latitude)
                    ngx.say("longitude: " .. result.longitude)
                    ngx.say("zip_code: " .. result.zip_code)
                    ngx.say("time_zone: " .. result.time_zone)
                    ngx.say("isp: " .. result.isp)
                    ngx.say("domain: " .. result.domain)
                    ngx.say("net_speed: " .. result.net_speed)
                    ngx.say("idd_code: " .. result.idd_code)
                    ngx.say("area_code: " .. result.area_code)
                    ngx.say("weather_station_code: " .. result.weather_station_code)
                    ngx.say("weather_station_name: " .. result.weather_station_name)
                    ngx.say("mcc: " .. result.mcc)
                    ngx.say("mnc: " .. result.mnc)
                    ngx.say("mobile_brand: " .. result.mobile_brand)
                    ngx.say("elevation: " .. result.elevation)
                    ngx.say("usage_type: " .. result.usage_type)
                    ngx.say("address_type: " .. result.address_type)
                    ngx.say("category: " .. result.category)
                    ngx.say("category_name: " .. result.category_name)
                    ngx.say("credits_consumed: " .. result.credits_consumed)

                    -- continent addon
                    if result["continent"] ~= nil then
                        ngx.say("continent => name: " .. result.continent.name)
                        ngx.say("continent => code: " .. result.continent.code)
                        ngx.say("continent => hemisphere: " .. table.concat(result.continent.hemisphere,","))
                        if lang ~= '' and result.continent.translations[lang] ~= nil then
                            ngx.say("continent => translations => " .. lang .. ": " .. result.continent.translations[lang])
                        end
                    end

                    -- country addon
                    if result["country"] ~= nil then
                        ngx.say("country => name: " .. result.country.name)
                        ngx.say("country => alpha3_code: " .. result.country.alpha3_code)
                        ngx.say("country => numeric_code: " .. result.country.numeric_code)
                        ngx.say("country => demonym: " .. result.country.demonym)
                        ngx.say("country => flag: " .. result.country.flag)
                        ngx.say("country => capital: " .. result.country.capital)
                        ngx.say("country => total_area: " .. result.country.total_area)
                        ngx.say("country => population: " .. result.country.population)
                        ngx.say("country => idd_code: " .. result.country.idd_code)
                        ngx.say("country => tld: " .. result.country.tld)
                        ngx.say("country => is_eu: " .. tostring(result.country.is_eu))
                        if lang ~= '' and result.country.translations[lang] ~= nil then
                            ngx.say("country => translations => " .. lang .. ": " .. result.country.translations[lang])
                        end

                        ngx.say("country => currency => code: " .. result.country.currency.code)
                        ngx.say("country => currency => name: " .. result.country.currency.name)
                        ngx.say("country => currency => symbol: " .. result.country.currency.symbol)

                        ngx.say("country => language => code: " .. result.country.language.code)
                        ngx.say("country => language => name: " .. result.country.language.name)
                    end

                    -- region addon
                    if result["region"] ~= nil then
                        ngx.say("region => name: " .. result.region.name)
                        ngx.say("region => code: " .. result.region.code)
                        if lang ~= '' and result.region.translations[lang] ~= nil then
                            ngx.say("region => translations => " .. lang .. ": " .. result.region.translations[lang])
                        end
                    end

                    -- city addon
                    if result["city"] ~= nil then
                        ngx.say("city => name: " .. result.city.name)
                        if lang ~= '' and result.city.translations[lang] ~= nil then
                            ngx.say("city => translations => " .. lang .. ": " .. result.city.translations[lang])
                        end
                    end

                    -- geotargeting addon
                    if result["geotargeting"] ~= nil then
                        ngx.say("geotargeting => metro: " .. result.geotargeting.metro)
                    end

                    -- country_groupings addon
                    if result["country_groupings"] ~= nil then
                        for i,v in ipairs(result.country_groupings) do
                            ngx.say("country_groupings => #" .. i .. " => acronym: " .. result.country_groupings[i].acronym)
                            ngx.say("country_groupings => #" .. i .. " => name: " .. result.country_groupings[i].name)
                        end
                    end

                    -- time_zone_info addon
                    if result["time_zone_info"] ~= nil then
                        ngx.say("time_zone_info => olson: " .. result.time_zone_info.olson)
                        ngx.say("time_zone_info => current_time: " .. result.time_zone_info.current_time)
                        ngx.say("time_zone_info => gmt_offset: " .. result.time_zone_info.gmt_offset)
                        ngx.say("time_zone_info => is_dst: " .. result.time_zone_info.is_dst)
                        ngx.say("time_zone_info => sunrise: " .. result.time_zone_info.sunrise)
                        ngx.say("time_zone_info => sunset: " .. result.time_zone_info.sunset)
                    end

                    local result2 = ws:get_credit()
                    ngx.say("Credit Balance: " .. result2.response)
                else
                    ngx.say("Error: " .. result.response)
                end
            }
        }
    }
}
```