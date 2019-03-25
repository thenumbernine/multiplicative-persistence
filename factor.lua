#!/usr/bin/env luajit
local big = require 'bignumber'
local factors = require 'factors'

--local x = big(1000)
local x = big'277777788888899'

print(x,':')
local fs = factors(x)
for _,f in ipairs(fs) do
	print(f)
end
