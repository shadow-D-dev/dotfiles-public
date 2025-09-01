local M = {}

local function normalize_hex(hex)
  if not hex or type(hex) ~= "string" then
    return nil
  end
  hex = hex:gsub("%s+", ""):gsub("#", "")
  if #hex == 3 then
    return "#" .. hex:sub(1, 1):rep(2) .. hex:sub(2, 2):rep(2) .. hex:sub(3, 3):rep(2)
  elseif #hex == 6 then
    return "#" .. hex
  else
    return nil
  end
end

local function hex_to_rgb(hex)
  hex = normalize_hex(hex)
  if not hex then
    return nil
  end
  hex = hex:gsub("#", "")
  local r = tonumber(hex:sub(1, 2), 16)
  local g = tonumber(hex:sub(3, 4), 16)
  local b = tonumber(hex:sub(5, 6), 16)
  if not (r and g and b) then
    return nil
  end
  return r, g, b
end

local function rgb_to_hex(r, g, b)
  r = math.max(0, math.min(255, math.floor(r + 0.5)))
  g = math.max(0, math.min(255, math.floor(g + 0.5)))
  b = math.max(0, math.min(255, math.floor(b + 0.5)))
  return string.format("#%02x%02x%02x", r, g, b)
end

-- Brighten toward white by amt (0..1). Example: amt = 0.18 -> move 18% toward white.
function M.brighten(hex, amt)
  amt = (type(amt) == "number") and amt or 0.18
  local r, g, b = hex_to_rgb(hex)
  if not r then
    return hex
  end
  local ch = function(c)
    return c + (255 - c) * amt
  end
  return rgb_to_hex(ch(r), ch(g), ch(b))
end

-- alias (backwards compatible)
function M.adjust(hex, factor)
  if type(factor) == "number" and factor > 1 then
    return M.brighten(hex, math.min(0.9, factor - 1))
  end
  return hex
end

return M
