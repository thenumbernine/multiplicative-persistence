local big = require 'bignumber'
local table = require 'ext.table'

local one = big(1)
local two = big(2)
local four = big(4)

local function factors(x)
	if x <= one then 
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
			isq = isq + i * 2 - 1
		end
	end
	if x > one then t:insert(x) end
	return t
end
return factors
