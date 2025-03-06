# Quickstart

## Dependencies

This library requires IP2Location BIN database to function. You may download the BIN database at

-   IP2Location LITE BIN Data (Free): <https://lite.ip2location.com>
-   IP2Location Commercial BIN Data (Comprehensive):
    <https://www.ip2location.com>

## IPv4 BIN vs IPv6 BIN

Use the IPv4 BIN file if you just need to query IPv4 addresses.

Use the IPv6 BIN file if you need to query BOTH IPv4 and IPv6 addresses.

## Installation

```
opm get ip2location/ip2location-resty
```

## Sample Codes

### Query geolocation information from BIN database

You can query the geolocation information from the IP2Location BIN database as below:

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
                local ip2loc = ip2location:new('/usr/local/ip2location/IP-COUNTRY-REGION-CITY-LATITUDE-LONGITUDE-ZIPCODE-TIMEZONE-ISP-DOMAIN-NETSPEED-AREACODE-WEATHER-MOBILE-ELEVATION-USAGETYPE-ADDRESSTYPE-CATEGORY-DISTRICT-ASN.BIN')
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
                ngx.say("district: " .. result.district)
                ngx.say("asn: " .. result.asn)
                ngx.say("as: " .. result.as)
                ip2loc:close()
            }
        }
    }
}
```
