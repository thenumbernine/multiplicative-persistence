local big = require 'bignumber'
-- report the number of steps of this multiplication-persistence
local function pers(x)
	for i=1,math.huge do
		x = productofdigits(x)
		if not x.maxExp or x.maxExp <= 0 then return i end
	end
end
return pers
