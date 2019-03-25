local big = require 'bignumber'
-- report the number of steps of this multiplication-persistence
local function pers(x)
	for i=1,math.huge do
		local s = big(x[0]) 
		for j=1,#x do
			s = s * big(x[j])
		end
		x = s
		if not x.maxExp or x.maxExp <= 0 then return i end
	end
end
return pers
