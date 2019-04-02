local big = require 'bignumber'
local function productofdigits(x)
	local s = big(x[0], x.base)
	for j=1,#x do
		s = s * big(x[j], x.base)
	end
	return s
end
return productofdigits
