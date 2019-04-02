local big = require 'bignumber'
local table = require 'ext.table'

local function factors(x)
	local one = big(1, x.base)
	local two = big(2, x.base)
	local four = big(4, x.base)
	
	if x <= 1 then 
		return table() 
	end
	if x == two then 
		return table{x} 
	end

	local t = table()
	local i = two
	local isq = four
	while isq <= x do
		local b,r = x:intdiv(i)
		if r:isZero() then
			x = b
			t:insert(i)
			i = two
			isq = four
		else
			i = i + 1
			isq = isq + i * two - 1
		end
	end
	if x > 1 then t:insert(x) end
	return t
end
return factors
