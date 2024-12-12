local cjson = require "cjson"
local http = require "resty.http"
local httpc = http.new()

-- for debugging purposes
-- local function printme(stuff)
  -- local inspect = require('inspect')
  -- print(inspect(stuff))
-- end

-- local function printmestr(stuff)
  -- local inspect = require('inspect')
  -- return (inspect(stuff))
-- end

ip2locationwebservice = {
  apikey = "",
  apipackage = "",
  usessl = false
}
ip2locationwebservice.__index = ip2locationwebservice

ip2locationresult = {
  response = '',
  country_code = '',
  country_name = '',
  region_name = '',
  city_name = '',
  latitude = 0,
  longitude = 0,
  zip_code = '',
  time_zone = '',
  isp = '',
  domain = '',
  net_speed = '',
  idd_code = '',
  area_code = '',
  weather_station_code = '',
  weather_station_name = '',
  mcc = '',
  mnc = '',
  mobile_brand = '',
  elevation = 0,
  usage_type = '',
  address_type = '',
  category = '',
  category_name = '',
  geotargeting = nil,
  continent = nil,
  country = nil,
  country_groupings = nil,
  region = nil,
  city = nil,
  time_zone_info = nil,
  credits_consumed = 0
}
ip2locationresult.__index = ip2locationresult

-- initialize the component with the web service configuration
function ip2locationwebservice:open(apikey, apipackage, usessl)
  local x = {}
  setmetatable(x, ip2locationwebservice)  -- make ip2locationwebservice handle lookup

  x.apikey = apikey
  x.apipackage = apipackage
  x.usessl = usessl

  return x
end

-- main query
function ip2locationwebservice:lookup(ipaddress, addon, lang)
  local protocol = "http"
  if self.usessl then
    protocol = "https"
  end

  local jsonstr = "{}"
  local res, err = httpc:request_uri(protocol .. "://api.ip2location.com/v2/?key=" .. ngx.escape_uri(self.apikey) .. "&package=" .. ngx.escape_uri(self.apipackage) .. "&ip=" .. ngx.escape_uri(ipaddress) .. "&addon=" .. ngx.escape_uri(addon) .. "&lang=" .. ngx.escape_uri(lang), { method = "GET", ssl_verify = false })
  if res then
    jsonstr = res.body
  end
  local result = cjson.decode(jsonstr)
  setmetatable(result, ip2locationresult)
  return result
end

-- check web service credit balance
function ip2locationwebservice:get_credit()
  local protocol = "http"
  if self.usessl then
    protocol = "https"
  end

  local jsonstr = "{}"
  local res, err = httpc:request_uri(protocol .. "://api.ip2location.com/v2/?key=" .. ngx.escape_uri(self.apikey) .. "&check=true", { method = "GET", ssl_verify = false })
  if res then
    jsonstr = res.body
  end
  local result = cjson.decode(jsonstr)
  setmetatable(result, ip2locationresult)

  return result
end

return ip2locationwebservice
