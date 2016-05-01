--[[ Utils for Debugging ]]

require('util/base64')

JSON = require('util/json')
clog = require('util/clog')

function DebugPrint(...)
  local spew = Convars:GetInt('debug_mode') or -1
  local verbose = Convars:GetInt('debug_verbose') or -1
  
  if spew == -1 and DEBUG_MODE then
    spew = 1
  end
  if verbose == -1 and DEBUG_VERBOSE then
    verbose = 1
  end

  if spew == 1 then
    if verbose == 1 then
      local func = debug.getinfo(2, "n").name
      local line = debug.getinfo(2, "l").currentline
      local source = debug.getinfo(2, "S").source

      if func == nil then
        print('[DEBUG] ' .. source .. '::' .. line .. ':: ' .. ...)
      else
        print('[DEBUG] ' .. func .. '::' .. source .. '::' .. line .. ':: ' .. ...)
      end

    else
      print('[DEBUG] ' .. ...)
    end
  end
end

function DebugPrintTable(...)
  local spew = Convars:GetInt('debug_mode') or -1
  local verbose = Convars:GetInt('debug_verbose') or -1

  if spew == -1 and DEBUG_MODE then
    spew = 1
  end
  if verbose == -1 and DEBUG_VERBOSE then
    verbose = 1
  end

  if spew == 1 then
    if verbose == 1 then
      DeepPrintTable(...)
    else
      PrintTable(...)
    end
  end
end

function PrintTable(t, indent, done)
  if type(t) ~= "table" then
    return
  end

  done = done or {}
  done[t] = true
  indent = indent or 0

  local l = {}
  for k, v in pairs(t) do
    table.insert(l, k)
  end

  table.sort(l)
  for k, v in ipairs(l) do
    if v ~= 'FDesc' then
      local value = t[v]

      if type(value) == "table" and not done[value] then
        done [value] = true
        print(string.rep ("\t", indent)..tostring(v)..":")
        PrintTable (value, indent + 2, done)
      elseif type(value) == "userdata" and not done[value] then
        done [value] = true
        print(string.rep ("\t", indent)..tostring(v)..": "..tostring(value))
        PrintTable ((getmetatable(value) and getmetatable(value).__index) or getmetatable(value), indent + 2, done)
      else
        if t.FDesc and t.FDesc[v] then
          print(string.rep ("\t", indent)..tostring(t.FDesc[v]))
        else
          print(string.rep ("\t", indent)..tostring(v)..": "..tostring(value))
        end
      end
    end
  end
end

COLOR_NONE = '\x06'
COLOR_GRAY = '\x06'
COLOR_GREY = '\x06'
COLOR_GREEN = '\x0C'
COLOR_DPURPLE = '\x0D'
COLOR_SPINK = '\x0E'
COLOR_DYELLOW = '\x10'
COLOR_PINK = '\x11'
COLOR_RED = '\x12'
COLOR_LGREEN = '\x15'
COLOR_BLUE = '\x16'
COLOR_DGREEN = '\x18'
COLOR_SBLUE = '\x19'
COLOR_PURPLE = '\x1A'
COLOR_ORANGE = '\x1B'
COLOR_LRED = '\x1C'
COLOR_GOLD = '\x1D'

function Test(event)
    print("[TRIGGERED]")
end