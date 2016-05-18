--
-- clog.lua
--
-- Copyright (c) 2016 rxi
--
-- This library is free software; you can redistribute it and/or modify it
-- under the terms of the MIT license. See LICENSE for details.
--

local clog = { _version = "0.1.0" }

local time_start = string.format("%s_%s", GetSystemDate(), GetSystemTime())

if(time_start:match("%W")) then
  time_start = time_start:gsub("%W","-")
end

clog.usecolor = true
clog.level = "trace"
clog.outpath = "../dota_addons/battle/logs/"
clog.outfile = string.format("%sevents_%s.htm", clog.outpath, time_start)

local modes = {
  { name = "trace",   color = "\27[34m", },
  { name = "debug",   color = "\27[36m", },
  { name = "info",    color = "\27[32m", },
  { name = "warning", color = "\27[33m", },
  { name = "error",   color = "\27[31m", },
  { name = "fatal",   color = "\27[35m", },
}

local log_header = [[<html><head>
                     <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
                     <meta http-equiv="Pragma" content="no-cache">
                     <meta http-equiv="Expires" content="-1"></head>
                     <body><br>/events.htm<br><br><table border="1"><tbody>
                     <tr><th>Date and Time</th>
                     <th>Level</th>
                     <th>Class</th>
                     <th>Source</th>
                     <th>Information</th></tr>]]

InitLogFile(clog.outfile, log_header)

local levels = {}
for i, v in ipairs(modes) do
  levels[v.name] = i
end


local round = function(x, increment)
  increment = increment or 1
  x = x / increment
  return (x > 0 and math.floor(x + .5) or math.ceil(x - .5)) * increment
end


local _tostring = tostring

local tostring = function(...)
  local t = {}
  for i = 1, select('#', ...) do
    local x = select(i, ...)
    if type(x) == "number" then
      x = round(x, .01)
    end
    t[#t + 1] = _tostring(x)
  end
  return table.concat(t, " ")
end


for i, x in ipairs(modes) do
  local nameupper = x.name:upper()
  clog[x.name] = function(string, class)
    
    -- Return early if we're below the clog level
    if i < levels[clog.level] then
      return
    end

    local msg = tostring(string)
    local info = debug.getinfo(2, "Sl")
    local lineinfo = "@" .. info.short_src .. "::" .. info.currentline
    local classinfo = class or "MESSAGE"

    -- Output to flight recorder
    if clog.outfile then
      local str = string.format("<tr><td>%s %s</td><td>%s</td><td>%s</td><td>%s</td><td>%s</td></tr>\n",
                                GetSystemDate(),
                                GetSystemTime(),
                                nameupper,
                                classinfo,
                                lineinfo,
                                msg)

      AppendToLogFile(clog.outfile, str)
                                  
    end
  end
end

return clog
