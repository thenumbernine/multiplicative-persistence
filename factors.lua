local big = require 'bignumber'
local table = require 'ext.table'
local function factors(x)
	if x <= big(1) then 
		return table() 
	end
	if x == big(2) then 
		return table{x} 
	end

	local t = table()
	local i = big(2)
	while true do
		local isq = i * i
		if isq > x then break end

		local b,r = x:intdiv(i)
		if r:isZero() then
			x = b
			t:insert(i)
			i = big(1)
		end

		i = i + big(1)
	end
	if x > big(1) then t:insert(x) end
	return t
end
return factors
