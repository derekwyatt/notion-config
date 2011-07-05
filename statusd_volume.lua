
local function get_volume()
   local f=io.popen('getvolstat','r')
   local s=f:read('*all')
   f:close()
   local _, _, master, mute = string.find(s, "(%d*) (%a*)")
  return master.."", mute..""
end

if statusd ~= nil then
   volume_timer = statusd.create_timer()
end

local function update_volume()
   local master, mute = get_volume()
   statusd.inform("volume_level", master)
   statusd.inform("volume_state", mute)
   if s == "off" then
       statusd.inform("volume_state_hint", "critical")
   else
       statusd.inform("volume_state_hint", "normal")
   end
   if statusd ~= nil then
      volume_timer:set(1000, update_volume)
   end
end

update_volume()
